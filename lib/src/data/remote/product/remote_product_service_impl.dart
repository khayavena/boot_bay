import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bootbay/src/data/remote/product/remote_product_service.dart';
import 'package:bootbay/src/model/ProductQuery.dart';
import 'package:bootbay/src/model/product.dart';

class RemoteProductServiceImpl implements RemoteProductService {
  Dio _dio;

  RemoteProductServiceImpl({
    @required Dio dio,
  }) : _dio = dio;

  @override
  Future<List<Product>> getAllProducts() async {
    Response response = await _dio.get('/api/product/all');
    return List<Product>.from(
        response.data.map((json) => Product.fromJson(json)));
  }

  @override
  Future<Product> getProductById(int id) async {
    Response response = await _dio.get('v2/beers/$id');
    return Product.fromJson(response.data);
  }

  @override
  Future<void> saveProduct(Product beer) async {
    // Response response = await _dio.post('uri');
  }

  @override
  Future<List<Product>> getMerchantProductsByCategory(
      String categoryId, String merchantId) async {
    Response response = await _dio
        .get('/api/product/all/category/$categoryId/mechacnt/$merchantId');
    return List<Product>.from(
        response.data.map((json) => Product.fromJson(json)));
  }

  @override
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    Response response = await _dio.get('/api/product/all/category/$categoryId');
    return List<Product>.from(
        response.data.map((json) => Product.fromJson(json)));
  }

  @override
  Future<List<Product>> getDefaultProducts(ProductQuery query) async {
    Response response =
        await _dio.post('/api/product/feed', data: query.toJson());
    return List<Product>.from(
        response.data.map((json) => Product.fromJson(json)));
  }
}
