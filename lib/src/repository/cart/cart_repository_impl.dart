import 'package:bootbay/src/data/local/product/cart_dao.dart';
import 'package:bootbay/src/helpers/network_helper.dart';
import 'package:bootbay/src/model/product.dart';
import 'package:bootbay/src/repository/cart/cart_repository.dart';
import 'package:flutter/material.dart';

class CartRepositoryImpl implements CartRepository {
  CartDao _cartDao;
  NetworkHelper _networkHelper;

  CartRepositoryImpl({
    @required CartDao cartDao,
    @required NetworkHelper networkHelper,
  })  : _cartDao = cartDao,
        _networkHelper = networkHelper;

  @override
  // ignore: missing_return
  Future<void> delete(Product product) async {
    await _cartDao.delete(product);
  }

  @override
  Future<List<Product>> findCartItems() async {
    return await _cartDao.findCartItems();
  }

  @override
  Future<Product> findProductById(String id) async {
    return await _cartDao.findProductById(id);
  }

  @override
  // ignore: missing_return
  Future<void> insertProduct(Product product) async {
    await _cartDao.insertProduct(product);
  }

  @override
  Future<bool> isExist(String id) async {
    return await _cartDao.isExist(id);
  }
}
