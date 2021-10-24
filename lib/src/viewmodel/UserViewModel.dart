import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/network_exception.dart';
import 'package:bootbay/src/model/AuthRequest.dart';
import 'package:bootbay/src/model/sys_user.dart';
import 'package:bootbay/src/repository/user/third_party_auth_repository.dart';
import 'package:bootbay/src/repository/user/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'ViewModel.dart';

class UserViewModel extends ViewModel {
  final UserRepository _userRepository;
  final ThirdPartyAuthRepository _thirdPartyAuthRepository;

  List<SysUser> _users = [];
  SysUser _user = SysUser();

  String dataErrorMessage;
  bool _loggedIn = false;
  Loader _loader = Loader.idl;

  UserViewModel({
    @required UserRepository userRepository,
    @required ThirdPartyAuthRepository thirdPartyAuthRepository,
  })  : _userRepository = userRepository,
        _thirdPartyAuthRepository = thirdPartyAuthRepository;

  Future<List<SysUser>> getAllCategories() async {
    _loader = Loader.busy;
    try {
      _users = await _userRepository.getAll();
      _loader = Loader.complete;
      notifyListeners();
      return _users;
    } on NetworkException catch (error) {
      _loader = Loader.error;
      dataErrorMessage = error.message;
      notifyListeners();
    } on DioError catch (error) {
      _loader = Loader.error;
      handleDioError(error);
    } catch (error) {
      _loader = Loader.error;
      notifyListeners();
    }
    return _users;
  }

  List<SysUser> get getUsers => _users;

  SysUser get getUser => _user;

  Future<SysUser> signUp(SysUser user) async {
    _loader = Loader.busy;
    notifyListeners();
    try {
      _user = await _userRepository.signUp(user);
      notifyListeners();
      _loader = Loader.complete;
      return _user;
    } on NetworkException catch (error) {
      _loader = Loader.error;
      dataErrorMessage = error.message;
      notifyListeners();
    } on DioError catch (error) {
      _loader = Loader.error;
      print(error);
      handleDioError(error);
    } catch (error) {
      _loader = Loader.error;
      notifyListeners();
    }
  }

  Future<void> logIn(final LoginOption loginOption) async {
    switch (loginOption) {
      case LoginOption.fb:
        await _thirdPartyAuthRepository.signInWithFacebook();
        break;
      case LoginOption.google:
        await _thirdPartyAuthRepository.signInWithGoogle();
        break;
      case LoginOption.twitter:
        // TODO: Handle this case.
        break;
    }
  }

  Future<SysUser> signIn() async {
    _loader = Loader.busy;
    notifyListeners();
    try {
      var currentUser = _thirdPartyAuthRepository.sysUser();
      _user = await _userRepository.signIn(AuthRequest());
      _loader = Loader.complete;
      notifyListeners();
      return _user;
    } on NetworkException catch (error) {
      _loader = Loader.error;
      dataErrorMessage = error.message;
      notifyListeners();
    } on DioError catch (error) {
      _loader = Loader.error;
      handleDioError(error);
    } catch (error) {
      _loader = Loader.error;
      notifyListeners();
    }
    return _user;
  }

  Loader get loader => _loader;

  Future<SysUser> saveCategory(SysUser category) {
    return _userRepository.update(category);
  }

  void resetLoader() {
    _loader = Loader.idl;
  }

  Future<bool> isLoggedIn() async {
    _loggedIn =  _thirdPartyAuthRepository.isLogIn;
    // if (_loggedIn) {
    //   var list = await _userRepository.getAll();
    //   _user = list[0];
    //   _loader = Loader.complete;
    // }
    _loader = Loader.complete;
    notifyListeners();
    return _loggedIn;
  }

  Future<bool> isLogOut(String id) async {
    _loggedIn = await _userRepository.logOut(id);
    notifyListeners();
    return _loggedIn;
  }

  bool get isLogged => _user != null;
}

enum LoginOption { fb, google, twitter }
