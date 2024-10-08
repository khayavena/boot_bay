import 'dart:developer';

import 'package:bootbay/src/model/pay_method/model/user_profile.dart';
import 'package:bootbay/src/pages/user/repository/user_additional_info.dart';
import 'package:bootbay/src/pages/user/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'third_party_auth_repository.dart';

class ThirdPartyAuthRepositoryImpl implements ThirdPartyAuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;
  final UserRepository _repository;
  late UserProfile _user;

  ThirdPartyAuthRepositoryImpl(
      {required UserRepository repository,
      required FirebaseAuth firebaseAuth,
      required GoogleSignIn googleSignIn,
      required FacebookAuth facebookAuth})
      : _repository = repository,
        _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn,
        _facebookAuth = facebookAuth;

  Future<void> signInWithGoogle() async {
    try {
      var googleSignInAccount = await _googleSignIn.signIn();
      var googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      var credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      var user = await _firebaseAuth.signInWithCredential(credential);
      var additionalInfo = user.additionalUserInfo?.profile;
      var data = GoogleAdditionalInfo.fromJson(additionalInfo!);
      _user = await _repository.thirdPartySignIn(
          data.givenName,
          data.familyName,
          googleSignInAccount?.email ?? "",
          user.user?.uid ?? "");
    } catch (e, s) {
      log(e.toString());
    }
  }

  @override
  Future<void> signInWithFacebook() async {
    var loginResult = await _facebookAuth.login();
    var facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken?.token ?? "");
    var userCredential =
        await _firebaseAuth.signInWithCredential(facebookAuthCredential);
    var additionalInfo = userCredential.additionalUserInfo?.profile;
    _user = await _repository.thirdPartySignIn(
        additionalInfo!['first_name'],
        additionalInfo['last_name'],
        userCredential.user?.email ?? "",
        userCredential.user?.uid ?? "");
  }

  @override
  Future<void> createUser(String email, password) async {
    try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user = await _repository.thirdPartySignIn("", "",
          userCredential.user?.email ?? "", userCredential.user?.uid ?? "");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> signInUser(String email, password) async {
    try {
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      _user = await _repository.thirdPartySignIn("", "",
          userCredential.user?.email ?? "", userCredential.user?.uid ?? "");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _facebookAuth.logOut();
    await _firebaseAuth.signOut();
  }

  UserProfile sysUser() => _user;

  Future<UserProfile> sysUserProfile() async {
    return await _repository.getCurrentUser(thirdPartyId);
  }

  bool get isLogIn {
    return _firebaseAuth.currentUser != null;
  }

  String get thirdPartyId {
    return _firebaseAuth.currentUser?.uid ?? "";
  }
}
