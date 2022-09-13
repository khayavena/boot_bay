import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/model/pay_method/model/product.dart';

abstract class CategoryDao {
  Future<List<Category>> findAll();

  Future<Product> findProductById(int id);

  Future<void> insertProduct(Category product);

  Future<void> insertAll(List<Category> beers);

  Future<void> updateAll(List<Category> beers);

  Future<void> update(Category category);
}
