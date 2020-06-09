import 'package:bootbay/src/model/ProductQuery.dart';
import 'package:bootbay/src/model/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getAllSelectedProducts();

  Future<List<Product>> getDefaultProducts(ProductQuery query);

  Future<List<Product>> getMerchantProductsByCategory(
      String categoryId, String merchantId);

  Future<List<Product>> getProductsByCategory(String categoryId);

  Future<Product> getProductById(int id);

  Future<bool> saveProduct(Product product);

  Future<bool> saveAllProducts(List<Product> products);

  Future<bool> updateAllProducts(List<Product> products);
}
