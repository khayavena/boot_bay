import 'package:bootbay/src/data/local/user/user_dao.dart';
import 'package:bootbay/src/model/sys_user.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';

class UserDaoImpl implements UserDao {
  static const String folderName = "Users";
  final _userStore = intMapStoreFactory.store(folderName);
  Database _database;

  UserDaoImpl({
    @required Database database,
  }) : _database = database;

  @override
  Future<List<SysUser>> findAll() async {
    final recordSnapshot = await _userStore.find(_database);
    return recordSnapshot.map((snapshot) {
      final student = SysUser.fromJson(snapshot.value);
      return student;
    }).toList();
  }

  @override
  Future<SysUser> findById(String id) async {
    final recordSnapshot = await _userStore.findFirst(_database, finder: Finder(filter: Filter.equals('id', id)));
    return SysUser.fromJson(recordSnapshot.value);
  }

  @override
  Future<SysUser> findByThirdPartyId(String id) async {
    final recordSnapshot =
        await _userStore.findFirst(_database, finder: Finder(filter: Filter.equals('thirdPartyId', id)));
    return SysUser.fromJson(recordSnapshot.value);
    ;
  }

  @override
  Future<void> insert(SysUser user) async {
    int b = await _userStore.add(_database, user.toJson());
    print('User status $b');
  }

  @override
  Future<void> insertAll(List<SysUser> users) {
    // TODO: implement insertAll
    throw UnimplementedError();
  }

  @override
  Future<void> update(SysUser user) async {
    var finder = Finder(
      filter: Filter.equals('id', user.id),
    );
    int b = await _userStore.update(_database, user.toJson(), finder: finder);
    print('User status $b');
  }

  @override
  Future<void> updateAll(List<SysUser> users) {
    // TODO: implement updateAll
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAllUser(String id) async {
    int delete = await _userStore.delete(_database, finder: Finder(filter: Filter.equals('id', id)));
  }

  @override
  Future<void> clear() {
    // TODO: implement clear
    throw UnimplementedError();
  }
}
