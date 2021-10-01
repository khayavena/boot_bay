import 'package:bootbay/src/model/product.dart';

abstract class WishListRepository {
  Future<List<Product>> findItems();

  Future<Product> findById(String id);

  Future<void> insert(Product product);

  Future<void> delete(Product product);

  Future<bool> isExist(String id);
}
