import 'package:flutter/material.dart';
import 'package:bootbay/src/data/remote/product/remote_category_service.dart';
import 'package:bootbay/src/helpers/network_exception.dart';
import 'package:bootbay/src/helpers/network_helper.dart';
import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/repository/category/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  RemoteCategoryService _remoteCategoryService;
  NetworkHelper _networkHelper;

  CategoryRepositoryImpl({
    @required RemoteCategoryService remoteProductService,
    @required NetworkHelper networkHelper,
  })  : _remoteCategoryService = remoteProductService,
        _networkHelper = networkHelper;

  @override
  Future<Category> addCategory(Category category) async {
    if (await _networkHelper.isNotConnected()) {
      throw NetworkException();
    }
    return _remoteCategoryService.addCategory(category);
  }

  @override
  Future<List<Category>> getAllCategories(String merchantId) async {
    if (await _networkHelper.isNotConnected()) {
      throw NetworkException();
    }
    return _remoteCategoryService.getAllCategories(merchantId);
  }

  @override
  Future<List<Category>> getCategories() async {
    if (await _networkHelper.isNotConnected()) {
      throw NetworkException();
    }
    return _remoteCategoryService.getCategories();
  }
}
