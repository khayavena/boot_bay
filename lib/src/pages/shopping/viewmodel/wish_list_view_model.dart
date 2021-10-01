import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/network_exception.dart';
import 'package:bootbay/src/model/product.dart';
import 'package:bootbay/src/pages/shopping/repository/wish/wish_list_repository.dart';
import 'package:bootbay/src/viewmodel/ViewModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class WishListViewModel extends ViewModel {
  WishListRepository _cartRepository;
  Loader _loader;
  bool _isItemExist = false;
  List<Product> _wishItems = [];
  String dataErrorMessage;

  String currentId = "";

  WishListViewModel({
    @required WishListRepository wishListRepository,
  }) : _cartRepository = wishListRepository;

  get wishItems => _wishItems;

  Future<void> saveProduct(Product product) async {
    await _cartRepository.insert(product);
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

  Future<List<Product>> getItems() async {
    _loader = Loader.busy;
    notifyListeners();
    try {
      _wishItems = await _cartRepository.findItems();
      _loader = Loader.complete;
      notifyListeners();
      return _wishItems;
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
    return _wishItems;
  }

  void updateItems() async {
    getItems();
  }

  double finalAmount() {
    double price = 0;
    int count = 0;
    _wishItems.forEach((x) {
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
    _wishItems.forEach((x) {
      items += x.id;
    });
    return items;
  }

  Loader get loader => _loader;

  bool get isItemExist => _isItemExist;

  void wishListAction(Product product) async {
    await checkExist(product);
    if (_isItemExist) {
      await deleteProduct(product);
    } else {
      await saveProduct(product);
    }
    notifyListeners();
    await getItems();
  }
}
