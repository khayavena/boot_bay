import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bootbay/src/data/remote/product/remote_category_service.dart';
import 'package:bootbay/src/model/category.dart';

class RemoteCategoryServiceImpl implements RemoteCategoryService {
  Dio _dio;

  RemoteCategoryServiceImpl({
    @required Dio dio,
  }) : _dio = dio;

  @override
  Future<Category> addCategory(Category category) async {
    Response response =
        await _dio.post('/api/category/add', data: category.toJson());
    return Category.fromJson(response.data);
  }

  @override
  Future<List<Category>> getAllCategories(String merchantId) async {
    Response response = await _dio.get('/api/category/all/$merchantId');
    return List<Category>.from(
        response.data.map((json) => Category.fromJson(json)));
  }

  @override
  Future<List<Category>> getCategories() async {
    Response response = await _dio.get('/api/category/all');
    return List<Category>.from(
        response.data.map((json) => Category.fromJson(json)));
  }
}
