import 'package:bootbay/src/model/sys_user.dart';

abstract class ThirdPartyAuthRepository {
  Future<void> signInWithGoogle();

  Future<void> createUser(String email, password);
  Future<void> signInUser(String email, password);
  Future<void> signInWithFacebook();

  Future<void> signOut();

  SysUser sysUser();
}
