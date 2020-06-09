import 'package:bootbay/src/model/ProductQuery.dart';
import 'package:bootbay/src/model/product.dart';

abstract class RemoteProductService {
  Future<List<Product>> getAllProducts();

  Future<Product> getProductById(int id);

  Future<List<Product>> getMerchantProductsByCategory(
      String categoryId, String merchantId);

  Future<List<Product>> getProductsByCategory(String categoryId);

  Future<void> saveProduct(Product product);

  Future<List<Product>> getDefaultProducts(ProductQuery query);
}
