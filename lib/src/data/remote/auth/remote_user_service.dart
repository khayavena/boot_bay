import 'package:bootbay/src/model/AuthRequest.dart';
import 'package:bootbay/src/model/user.dart';

abstract class RemoteUserService {
  Future<User> signUp(User user);

  Future<User> update(User user);

  Future<List<User>> getAll();

  Future<User> signIn(AuthRequest authRequest);
}
