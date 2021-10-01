import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/network_exception.dart';
import 'package:bootbay/src/model/AuthRequest.dart';
import 'package:bootbay/src/model/user.dart';
import 'package:bootbay/src/repository/user/user_repository.dart';
import 'package:bootbay/src/viewmodel/ViewModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ViewModel {
  UserRepository _userRepository;

  List<User> _users = [];
  User _user = User();

  String dataErrorMessage;
  bool _loggedIn = false;
  Loader _loader = Loader.idl;

  UserViewModel({
    @required UserRepository userRepository,
  }) : _userRepository = userRepository;

  Future<List<User>> getAllCategories() async {
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

  List<User> get getUsers => _users;

  User get getUser => _user;

  Future<User> signUp(User user) async {
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

  Future<User> signIn(AuthRequest authRequest) async {
    _loader = Loader.busy;
    notifyListeners();
    try {
      _user = await _userRepository.signIn(authRequest);
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

  Future<User> saveCategory(User category) {
    return _userRepository.update(category);
  }

  void resetLoader() {
    _loader = Loader.idl;
  }

  Future<bool> isLoggedIn() async {
    _loggedIn = await _userRepository.isLoggedIn();
    if (_loggedIn) {
      var list = await _userRepository.getAll();
      _user = list[0];
      _loader = Loader.complete;
    }

    notifyListeners();
    return _loggedIn;
  }

  Future<bool> isLogOut(String id) async {
    _loggedIn = await _userRepository.logOut(id);
    notifyListeners();
    return _loggedIn;
  }

  bool get isLogged => _loggedIn;
}
