import 'package:bootbay/src/model/user.dart';

abstract class UserDao {
  Future<List<User>> findAll();

  Future<User> findById(String id);

  Future<void> insert(User user);

  Future<void> insertAll(List<User> users);

  Future<void> updateAll(List<User> users);

  Future<void> update(User user);

  Future<void> deleteAllUser(String id);
}
