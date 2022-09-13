import 'package:bootbay/src/model/pay_method/model/product.dart';

abstract class CartDao {
  Future<List<Product>> findCartItems();

  Future<Product> findProductById(String id);

  Future<void> insertProduct(Product product);

  Future<void> delete(Product product);

  Future<bool> isExist(String id);
}
