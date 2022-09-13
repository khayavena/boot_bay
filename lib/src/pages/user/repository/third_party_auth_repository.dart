import 'package:bootbay/src/model/pay_method/model/user_profile.dart';

abstract class ThirdPartyAuthRepository {
  Future<void> signInWithGoogle();

  Future<void> createUser(String email, password);

  Future<void> signInUser(String email, password);

  Future<void> signInWithFacebook();

  Future<void> signOut();

  bool get isLogIn;

  UserProfile sysUser();

  Future<UserProfile> sysUserProfile();
}
