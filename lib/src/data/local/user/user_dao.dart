import 'package:bootbay/src/model/sys_user.dart';

abstract class UserDao {
  Future<List<SysUser>> findAll();

  Future<SysUser> findById(String id);

  Future<SysUser> findByThirdPartyId(String id);

  Future<void> insert(SysUser user);

  Future<void> insertAll(List<SysUser> users);

  Future<void> updateAll(List<SysUser> users);

  Future<void> update(SysUser user);

  Future<void> deleteAllUser(String id);

  Future<void> clear();
}
