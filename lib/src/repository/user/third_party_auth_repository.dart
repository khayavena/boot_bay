import 'package:bootbay/src/model/sys_user.dart';

abstract class ThirdPartyAuthRepository {
  Future<void> signInWithGoogle();


  Future<void> signOut();

  Future<void> signInWithFacebook();

  SysUser sysUser();
}
