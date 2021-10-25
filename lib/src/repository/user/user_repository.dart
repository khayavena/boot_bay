import 'package:bootbay/src/model/AuthRequest.dart';
import 'package:bootbay/src/model/user_profile.dart';

abstract class UserRepository {
  Future<UserProfile> signUp(UserProfile user);

  Future<UserProfile> signIn(AuthRequest authRequest);

  Future<UserProfile> update(UserProfile user);

  Future<UserProfile> getCurrentUser(String id);

  Future<List<UserProfile>> getAll();

  Future<bool> isLoggedIn();

  Future<bool> logOut(String id);

  Future<UserProfile> thirdPartySignIn(String firstName, String lasName, String email, String idToken);
}
