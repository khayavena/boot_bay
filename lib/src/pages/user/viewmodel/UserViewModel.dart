import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/network_exception.dart';
import 'package:bootbay/src/model/AuthRequest.dart';
import 'package:bootbay/src/model/pay_method/model/user_profile.dart';
import 'package:bootbay/src/pages/user/repository/third_party_auth_repository.dart';
import 'package:bootbay/src/pages/user/repository/user_repository.dart';
import 'package:dio/dio.dart';

import '../../../viewmodel/ViewModel.dart';

class UserViewModel extends ViewModel {
  final UserRepository _userRepository;
  final ThirdPartyAuthRepository _thirdPartyAuthRepository;

  List<UserProfile> _users = [];
  UserProfile _user = UserProfile();

  late String dataErrorMessage;
  bool _loggedIn = false;
  Loader _loader = Loader.idl;

  UserViewModel({
    required UserRepository userRepository,
    required ThirdPartyAuthRepository thirdPartyAuthRepository,
  })  : _userRepository = userRepository,
        _thirdPartyAuthRepository = thirdPartyAuthRepository;

  Future<List<UserProfile>> getAllUsers() async {
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

  List<UserProfile> get getUsers => _users;

  UserProfile get getUser => _user;

  Future<UserProfile> signUp(UserProfile user) async {
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
    return _user;
  }

  Future<void> logIn(final LoginOption loginOption) async {
    _loader = Loader.busy;
    notifyListeners();
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
    _loader = Loader.complete;
    notifyListeners();
  }

  Future<UserProfile> signIn() async {
    _loader = Loader.busy;
    notifyListeners();
    try {
      _user = await _userRepository.signIn(AuthRequest(thirdPartyId: ''));
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

  Future<UserProfile> getCurrentUser() async {
    return await _thirdPartyAuthRepository.sysUserProfile();
  }

  Loader get loader => _loader;

  Future<UserProfile> saveCategory(UserProfile profile) {
    return _userRepository.update(profile);
  }

  void resetLoader() {
    _loader = Loader.idl;
  }

  bool isLoggedIn() {
    _loggedIn = _thirdPartyAuthRepository.isLogIn;
    return _loggedIn;
  }

  String get loginText => isLoggedIn() ? "Log Out" : "Log In";

  Future<bool> isLogOut(String id) async {
    _loggedIn = await _userRepository.logOut(id);
    notifyListeners();
    return _loggedIn;
  }
}

enum LoginOption { fb, google, twitter }
