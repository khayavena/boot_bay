import 'package:bootbay/src/model/AuthRequest.dart';
import 'package:bootbay/src/model/sys_user.dart';

abstract class UserRepository {
  Future<SysUser> signUp(SysUser user);

  Future<SysUser> signIn(AuthRequest authRequest);

  Future<SysUser> update(SysUser user);

  Future<List<SysUser>> getAll();

  Future<bool> isLoggedIn();

  Future<bool> logOut(String id);
  SysUser thirdPartySignIn1(String displayName, String email, String idToken);
  Future<SysUser> thirdPartySignIn(String displayName, String email, String idToken);
}
