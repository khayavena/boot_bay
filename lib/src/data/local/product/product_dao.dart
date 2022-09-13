import 'package:bootbay/src/model/pay_method/model/product.dart';

abstract class ProductDao {
  Future<List<Product>> findAllProducts();

  Future<Product> findProductById(String id);

  Future<void> insertProduct(Product product);

  Future<void> insertAll(List<Product> beers);

  Future<void> updateAll(List<Product> beers);

  Future<void> delete(Product product);
}
