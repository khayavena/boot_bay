import 'package:bootbay/src/model/AuthRequest.dart';
import 'package:bootbay/src/model/sys_user.dart';

abstract class RemoteUserService {
  Future<SysUser> signUp(SysUser user);

  Future<SysUser> update(SysUser user);

  Future<List<SysUser>> getAll();

  Future<SysUser> signIn(AuthRequest authRequest);
}
