import 'package:bootbay/src/model/product_query.dart';
import 'package:bootbay/src/model/pay_method/model/product.dart';
import 'package:bootbay/src/model/pay_method/model/product_response.dart';

abstract class ProductRepository {
  Future<List<Product>> getAllSelectedProducts();

  Future<List<Product>> getDefaultProducts(ProductQuery query);

  Future<List<Product>> getMerchantProductsByCategory(
      String categoryId, String merchantId);

  Future<List<Product>> getProductsByCategory(String categoryId);

  Future<Product> getProductById(String id);

  Future<bool> saveProduct(Product product);

  Future<ProductResponse> saveRemoteProduct(Product product);

  Future<bool> saveAllProducts(List<Product> products);

  Future<bool> updateAllProducts(List<Product> products);

  Future<void> delete(Product product);
}
