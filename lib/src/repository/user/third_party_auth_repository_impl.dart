import 'package:bootbay/src/model/sys_user.dart';
import 'package:bootbay/src/repository/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// import 'package:twitter_login/twitter_login.dart';

import 'third_party_auth_repository.dart';

class ThirdPartyAuthRepositoryImpl implements ThirdPartyAuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;
  final UserRepository _repository;
  SysUser _user;

  ThirdPartyAuthRepositoryImpl(
      {@required UserRepository repository,
      @required FirebaseAuth firebaseAuth,
      @required GoogleSignIn googleSignIn,
      @required FacebookAuth facebookAuth})
      : _repository = repository,
        _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn,
        _facebookAuth = facebookAuth;

  Future<void> signInWithGoogle() async {
    try {
      var googleSignInAccount = await _googleSignIn.signIn();
      var googleSignInAuthentication = await googleSignInAccount.authentication;
      var credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      var user = await _firebaseAuth.signInWithCredential(credential);
      var additionalInfo = user.additionalUserInfo.profile;
      _user = _repository.thirdPartySignIn1(
          googleSignInAccount.displayName, googleSignInAccount.email, googleSignInAuthentication.idToken);
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  SysUser sysUser() => _user;

  @override
  Future<void> signInWithFacebook() async {
    var loginResult = await _facebookAuth.login();
    var facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken.token);
    var userCredential = await _firebaseAuth.signInWithCredential(facebookAuthCredential);
    var additionalInfo = userCredential.additionalUserInfo.profile;
    _user = _repository.thirdPartySignIn1(
        userCredential.user.displayName, userCredential.user.email, userCredential.user.uid);
  }
}
