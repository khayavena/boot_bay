import 'package:bootbay/src/model/sys_user.dart';
import 'package:bootbay/src/repository/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'firebase_auth_repository.dart';

class ThirdPartyAuthRepositoryImpl implements ThirdPartyAuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final UserRepository _repository;
  SysUser _user;

  ThirdPartyAuthRepositoryImpl({UserRepository repository, FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _repository = repository,
        _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn;

  Future<void> signInWithGoogle() async {
    try {
      var googleSignInAccount = await _googleSignIn.signIn();
      var googleSignInAuthentication = await googleSignInAccount.authentication;
      var credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
      await _repository.thirdPartySignIn(
          googleSignInAccount.displayName, googleSignInAccount.email, googleSignInAuthentication.idToken);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  SysUser get sysUser => _user;
}
