import 'package:bootbay/src/model/product_query.dart';
import 'package:bootbay/src/model/product.dart';
import 'package:bootbay/src/model/product_response.dart';

abstract class RemoteProductService {
  Future<List<Product>> getAllProducts();

  Future<Product> getProductById(int id);

  Future<List<Product>> getMerchantProductsByCategory(
      String categoryId, String merchantId);

  Future<List<Product>> getProductsByCategory(String categoryId);

  Future<ProductResponse> saveRemoteProduct(Product product);

  Future<List<Product>> getDefaultProducts(ProductQuery query);
}
