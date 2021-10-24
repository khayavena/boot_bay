import 'package:bootbay/src/model/AuthRequest.dart';
import 'package:bootbay/src/model/sys_user.dart';

abstract class UserRepository {
  Future<SysUser> signUp(SysUser user);

  Future<SysUser> signIn(AuthRequest authRequest);

  Future<SysUser> update(SysUser user);

  Future<SysUser> getCurrentUser(String id);

  Future<List<SysUser>> getAll();

  Future<bool> isLoggedIn();

  Future<bool> logOut(String id);

  Future<SysUser> thirdPartySignIn(String firstName, String lasName, String email, String idToken);
}
