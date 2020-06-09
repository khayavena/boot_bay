
import 'package:bootbay/src/model/product.dart';

abstract class ProductDao {
  Future<List<Product>> findAllProducts();

  Future<Product> findProductById(int id);

  Future<void> insertProduct(Product product);

  Future<void> insertAll(List<Product> beers);

  Future<void> updateAll(List<Product> beers);
}
