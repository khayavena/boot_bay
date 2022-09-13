import 'package:bootbay/src/model/AuthRequest.dart';
import 'package:bootbay/src/model/pay_method/model/user_profile.dart';

abstract class RemoteUserDataSource {
  Future<UserProfile> signUp(UserProfile user);

  Future<UserProfile> update(UserProfile user);

  Future<List<UserProfile>> getAll();

  Future<UserProfile> signIn(AuthRequest authRequest);
}
