import 'package:bootbay/src/model/sys_user.dart';
import 'package:bootbay/src/repository/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      await _firebaseAuth.signInWithCredential(credential);
      // _user = await _repository.thirdPartySignIn(
      //     googleSignInAccount.displayName, googleSignInAccount.email, googleSignInAuthentication.idToken);
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
    await _facebookAuth.login(permissions: ['email']).then((value) async {
      var access = value.accessToken;
      var facebookAuthCredential = FacebookAuthProvider.credential(access.token);

      var userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    }).onError((error, stackTrace) {
      print(error);
    });

    // _user = await _repository.thirdPartySignIn(
    //     userCredential.user.displayName, userCredential.user.email, userCredential.user.uid);
  }






  // void getHttp(token) async {
  //   try {
  //     var response = await Dio().get(
  //         'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
  //     profile = FacebookUser.fromJson(response.data);
  //
  //     print('Profile Info :${profile.toString()}');
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Future<void> signInWithTwitter() {
    // TODO: implement signInWithTwitter
    throw UnimplementedError();
  }
}
