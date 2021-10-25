import 'package:bootbay/src/model/user_profile.dart';

abstract class UserDao {
  Future<List<UserProfile>> findAll();

  Future<UserProfile> findById(String id);

  Future<UserProfile> findByThirdPartyId(String id);

  Future<void> insert(UserProfile user);

  Future<void> insertAll(List<UserProfile> users);

  Future<void> updateAll(List<UserProfile> users);

  Future<void> update(UserProfile user);

  Future<void> deleteAllUser(String id);

  Future<void> clear();
}
