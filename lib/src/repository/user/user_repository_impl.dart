import 'package:bootbay/src/data/local/user/user_dao.dart';
import 'package:bootbay/src/data/remote/auth/remote_user_service.dart';
import 'package:bootbay/src/helpers/network_helper.dart';
import 'package:bootbay/src/model/AuthRequest.dart';
import 'package:bootbay/src/model/sys_user.dart';
import 'package:bootbay/src/repository/user/user_repository.dart';
import 'package:flutter/material.dart';

class UserRepositoryImpl implements UserRepository {
  RemoteUserService _authService;
  UserDao _userDao;
  NetworkHelper _networkHelper;

  UserRepositoryImpl(
      {@required RemoteUserService userService, @required NetworkHelper networkHelper, @required UserDao userDao})
      : _authService = userService,
        _networkHelper = networkHelper,
        _userDao = userDao;

  @override
  Future<SysUser> signUp(SysUser user) {
    return _authService.signUp(user);
  }

  @override
  Future<SysUser> update(SysUser user) {
    return _authService.update(user);
  }

  @override
  Future<List<SysUser>> getAll() {
    return _userDao.findAll();
  }

  @override
  Future<SysUser> signIn(AuthRequest authRequest) async {
    var user = await _authService.signIn(authRequest);
    _userDao.insert(user);
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
  SysUser thirdPartySignIn1(String displayName, String email, String idToken) {
    var provide = displayName;
    return SysUser(fullName: displayName,email: email,thirdPartyId: idToken);
  }

  @override
  Future<SysUser> thirdPartySignIn(String displayName, String email, String idToken) {
    // TODO: implement thirdPartySignIn
    throw UnimplementedError();
  }
}
