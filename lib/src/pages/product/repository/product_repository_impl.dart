import 'package:bootbay/src/data/local/product/product_dao.dart';
import 'package:bootbay/src/data/remote/product/remote_product_service.dart';
import 'package:bootbay/src/helpers/network_helper.dart';
import 'package:bootbay/src/model/pay_method/model/product.dart';
import 'package:bootbay/src/model/product_query.dart';
import 'package:bootbay/src/model/pay_method/model/product_response.dart';
import 'package:bootbay/src/pages/product/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  RemoteProductService _remoteProductService;
  ProductDao _localProductService;
  NetworkHelper _networkHelper;

  ProductRepositoryImpl({
    required RemoteProductService remoteProductService,
    required ProductDao localProductService,
    required NetworkHelper networkHelper,
  })  : _remoteProductService = remoteProductService,
        _localProductService = localProductService,
        _networkHelper = networkHelper;

  @override
  Future<List<Product>> getAllSelectedProducts() async {
    _localProductService.findAllProducts();
    return _localProductService.findAllProducts();
  }

  @override
  Future<Product> getProductById(String id) {
    return _localProductService.findProductById(id);
  }

  @override
  Future<bool> saveProduct(Product product) async {
    await _localProductService.insertProduct(product);
    return true;
  }

  @override
  Future<bool> saveAllProducts(List<Product> products) async {
    _localProductService.insertAll(products);
    return true;
  }

  @override
  Future<bool> updateAllProducts(List<Product> products) async {
    _localProductService.updateAll(products);
    return true;
  }

  @override
  Future<List<Product>> getMerchantProductsByCategory(
      String categoryId, String merchantId) {
    return _remoteProductService.getMerchantProductsByCategory(
        categoryId, merchantId);
  }

  @override
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    var products =
        await _remoteProductService.getProductsByCategory(categoryId);
    if (products.isNotEmpty) {
      _localProductService.insertAll(products);
    }
    return _localProductService.findAllProducts();
  }

  @override
  Future<List<Product>> getDefaultProducts(ProductQuery query) {
    return _remoteProductService.getDefaultProducts(query);
  }

  @override
  // ignore: missing_return
  Future<void> delete(Product product) async {
    _localProductService.delete(product);
  }

  @override
  Future<ProductResponse> saveRemoteProduct(Product product) {
    return _remoteProductService.saveRemoteProduct(product);
  }
}
