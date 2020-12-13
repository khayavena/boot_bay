import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/network_exception.dart';
import 'package:bootbay/src/model/product.dart';
import 'package:bootbay/src/repository/cart_repository.dart';
import 'package:bootbay/src/viewmodel/ViewModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CartViewModel extends ViewModel {
  CartRepository _cartRepository;
  Loader _loader;
  bool _isItemExist = false;
  List<Product> _cartItems = [];
  String dataErrorMessage;

  String currentId = "";

  CartViewModel({
    @required CartRepository cartRepository,
  }) : _cartRepository = cartRepository;

  get cartItems => _cartItems;

  Future<void> saveProduct(Product product) async {
    await _cartRepository.insertProduct(product);
    checkExist(product);
  }

  Future<void> deleteProduct(Product product) async {
    await _cartRepository.delete(product);
    checkExist(product);
  }

  Future<void> checkExist(Product product) async {
    currentId = product.id;
    _isItemExist = await _cartRepository.isExist(product.id);
    notifyListeners();
  }

  Future<bool> isCheck(Product product) async {
    _isItemExist = await _cartRepository.isExist(product.id);
    return _isItemExist;
  }

  Future<List<Product>> getCatItems() async {
    _loader = Loader.busy;
    notifyListeners();
    try {
      _cartItems = await _cartRepository.findCartItems();
      _loader = Loader.complete;
      notifyListeners();
      return _cartItems;
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
    return _cartItems;
  }

  double finalAmount() {
    double price = 0;
    int count = 0;
    _cartItems.forEach((x) {
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
    _cartItems.forEach((x) {
      items += x.id;
    });
    return items;
  }

  Loader get loader => _loader;

  bool get isItemExist => _isItemExist;

  void cartAction(Product product) async {
    await checkExist(product);
    if (_isItemExist) {
      deleteProduct(product);
    } else {
      saveProduct(product);
    }
    notifyListeners();
  }
}
