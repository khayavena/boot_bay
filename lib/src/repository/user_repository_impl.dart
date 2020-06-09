import 'package:bootbay/src/data/local/user/user_dao.dart';
import 'package:bootbay/src/data/remote/auth/remote_user_service.dart';
import 'package:bootbay/src/helpers/network_helper.dart';
import 'package:bootbay/src/model/AuthRequest.dart';
import 'package:bootbay/src/model/User.dart';
import 'package:bootbay/src/repository/user_repository.dart';
import 'package:flutter/material.dart';

class UserRepositoryImpl implements UserRepository {
  RemoteUserService _authService;
  UserDao _userDao;
  NetworkHelper _networkHelper;

  UserRepositoryImpl(
      {@required RemoteUserService userService,
      @required NetworkHelper networkHelper,
      @required UserDao userDao})
      : _authService = userService,
        _networkHelper = networkHelper,
        _userDao = userDao;

  @override
  Future<User> signUp(User user) {
    return _authService.signUp(user);
  }

  @override
  Future<User> update(User user) {
    return _authService.update(user);
  }

  @override
  Future<List<User>> getAll() {
    return _authService.getAll();
  }

  @override
  Future<User> signIn(AuthRequest authRequest) async {
    var user = await _authService.signIn(authRequest);
    _userDao.insert(user);
    return user;
  }
}
