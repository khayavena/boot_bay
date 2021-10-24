import 'package:bootbay/src/data/local/user/user_dao.dart';
import 'package:bootbay/src/data/remote/user/remote_user_data_source.dart';
import 'package:bootbay/src/helpers/network_helper.dart';
import 'package:bootbay/src/model/AuthRequest.dart';
import 'package:bootbay/src/model/sys_user.dart';
import 'package:bootbay/src/repository/user/user_repository.dart';
import 'package:flutter/material.dart';

class UserRepositoryImpl implements UserRepository {
  RemoteUserDataSource _remoteUserDataSource;
  UserDao _userDao;
  NetworkHelper _networkHelper;

  UserRepositoryImpl(
      {@required RemoteUserDataSource remoteUserDataSource,
      @required NetworkHelper networkHelper,
      @required UserDao userDao})
      : _remoteUserDataSource = remoteUserDataSource,
        _networkHelper = networkHelper,
        _userDao = userDao;

  @override
  Future<SysUser> signUp(SysUser user) {
    return _remoteUserDataSource.signUp(user);
  }

  @override
  Future<SysUser> update(SysUser user) {
    return _remoteUserDataSource.update(user);
  }

  @override
  Future<List<SysUser>> getAll() {
    return _userDao.findAll();
  }

  @override
  Future<SysUser> signIn(AuthRequest authRequest) async {
    var user = await _remoteUserDataSource.signIn(authRequest);
    await _userDao.clear();
    await _userDao.insert(user);
    return user;
  }

  @override
  Future<bool> isLoggedIn() async {
    List<SysUser> list = await _userDao.findAll();
    if (list != null && list.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> logOut(String id) async {
    _userDao.deleteAllUser(id);
    return await isLoggedIn() == false;
  }

  @override
  Future<SysUser> thirdPartySignIn(String firstName, String lastName, String email, String idToken) async {
    var user = SysUser(
        firstName: firstName,
        dateOfBirth: DateTime.now().toString(),
        lastName: lastName,
        password: 'password',
        email: email,
        thirdPartyId: idToken);
    user = await _remoteUserDataSource.signUp(user);
    await _userDao.insert(user);
    return user;
  }

  @override
  Future<SysUser> getCurrentUser(String id) async {
    return await _userDao.findByThirdPartyId(id);
  }
}
