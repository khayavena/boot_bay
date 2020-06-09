import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/network_exception.dart';
import 'package:bootbay/src/model/ProductQuery.dart';
import 'package:bootbay/src/model/product.dart';
import 'package:bootbay/src/repository/product_repository.dart';
import 'package:bootbay/src/viewmodel/ViewModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProductViewModel extends ViewModel {
  ProductRepository _productRepository;
  Loader _loader;
  List<Product> _products = [];
  Product _product = Product();
  String dataErrorMessage;

  ProductViewModel({
    @required ProductRepository productRepository,
  }) : _productRepository = productRepository;

  Future<void> saveProduct(Product product) {
    return _productRepository.saveProduct(product);
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

  double finalAmount() {
    double price = 0;
    int count = 0;
    getProducts.forEach((x) {
      count++;
      price += x.price * count;
    });
    return price;
  }

  String currency() {
    return 'USD';
  }

  String itemIds() {
    String items = '';

    getProducts.forEach((x) {
      items += x.id;
    });
    return items;
  }

  List<Product> get getProducts => _products;

  Product get getProduct => _product;

  Loader get loader => _loader;
}
