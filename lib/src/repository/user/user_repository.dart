import 'package:bootbay/src/model/AuthRequest.dart';
import 'package:bootbay/src/model/User.dart';

abstract class UserRepository {
  Future<User> signUp(User user);

  Future<User> signIn(AuthRequest authRequest);

  Future<User> update(User user);

  Future<List<User>> getAll();

  Future<bool> isLoggedIn();

  Future<bool> logOut(String id);
}
