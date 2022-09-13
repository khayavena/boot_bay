import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/network_exception.dart';
import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/model/pay_method/model/product.dart';
import 'package:bootbay/src/model/product_query.dart';
import 'package:bootbay/src/model/pay_method/model/product_response.dart';
import 'package:bootbay/src/pages/product/repository/product_repository.dart';
import 'package:bootbay/src/viewmodel/ViewModel.dart';
import 'package:dio/dio.dart';

class ProductViewModel extends ViewModel {
  ProductRepository _productRepository;
  late Loader _loader = Loader.idl;
  List<Product> _products = [];
  List<Product> cartItems = [];
  Product _product = Product();
  late Category _category;
  late ProductResponse _productResponse;
  late String dataErrorMessage;

  ProductViewModel({
    required ProductRepository productRepository,
  }) : _productRepository = productRepository;

  void saveProduct(Product product) {
    _productRepository.saveProduct(product);
  }

  Future<Product> saveRemoteProduct(
      String merchantId, String name, description, double price) async {
    if (_category != null) {
      _product.categoryId = _category.id??'';
      var productResponse = await _productRepository.saveRemoteProduct(Product(
          categoryId: _category.id??'',
          merchantId: merchantId,
          name: name,
          description: description,
          price: price));
      _product = productResponse.item;
      notifyListeners();
    }
    return _product;
  }

  Future<Product> editRemoteProduct(Product product) async {
    if (_category != null) {
      product.categoryId = _category.id??'';
      var productResponse = await _productRepository.saveRemoteProduct(product);
      _product = productResponse.item;
      notifyListeners();
    }
    return _product;
  }

  void deleteProduct(Product product) {
    _productRepository.delete(product);
  }

  Future<List<Product>> getMerchantProductsByCategory(
      String categoryId, String merchantId) async {
    _loader = Loader.busy;
    notifyListeners();
    try {
      _products = await _productRepository.getMerchantProductsByCategory(
          categoryId, merchantId);

      _loader = Loader.complete;
      notifyListeners();
      return _products;
    } on NetworkException catch (error) {
      dataErrorMessage = error.message;
      _loader = Loader.error;
      notifyListeners();
    } on DioError catch (error) {
      _loader = Loader.error;
      handleDioError(error);
    } catch (error) {
      _loader = Loader.error;
      notifyListeners();
    }
    return _products;
  }

  Future<List<Product>> queryProducts(ProductQuery productQuery) async {
    _loader = Loader.busy;
    notifyListeners();
    try {
      _products = await _productRepository.getDefaultProducts(productQuery);
      _loader = Loader.complete;
      notifyListeners();
      return _products;
    } on NetworkException catch (error) {
      dataErrorMessage = error.message;
      _loader = Loader.error;
      notifyListeners();
    } on DioError catch (error) {
      _loader = Loader.error;
      handleDioError(error);
    } catch (error) {
      _loader = Loader.error;
      notifyListeners();
    }
    return _products;
  }

  Future<List<Product>> getCatItems() async {
    _loader = Loader.busy;
    notifyListeners();
    try {
      cartItems = await _productRepository.getAllSelectedProducts();

      _loader = Loader.complete;
      notifyListeners();
      return cartItems;
    } on NetworkException catch (error) {
      dataErrorMessage = error.message;
      _loader = Loader.error;
      notifyListeners();
    } on DioError catch (error) {
      _loader = Loader.error;
      handleDioError(error);
    } catch (error) {
      _loader = Loader.error;
      notifyListeners();
    }
    return cartItems;
  }

  double finalAmount() {
    double price = 0;
    int count = 0;
    cartItems.forEach((x) {
      count++;
      price += x.price * count;
    });
    return price;
  }

  String currency() {
    return 'ZAR';
  }

  String itemIds() {
    String items = '';

    getProducts.forEach((x) {
      items += x.id;
    });
    return items;
  }

  List<Product> get getProducts => _products;

  void setSelectedCategory(Category category) {
    this._category = category;
    print('Category set =${getSelectedCategory.name}');
  }

  Category get getSelectedCategory => _category;

  ProductResponse get productResponse => _productResponse;

  Product get getProduct => _product;

  Loader get loader => _loader;
}
