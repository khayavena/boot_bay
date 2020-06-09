import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/network_exception.dart';
import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/repository/category_repository.dart';
import 'package:bootbay/src/viewmodel/ViewModel.dart';

class CategoryViewModel extends ViewModel {
  CategoryRepository _categoryRepository;

  List<Category> _categories = [];
  Set<Category> _selectedCategories = Set();
  Category _category = Category();

  String dataErrorMessage;

  Loader _loader = Loader.idl;

  CategoryViewModel({
    @required CategoryRepository categoryRepository,
  }) : _categoryRepository = categoryRepository;

  Future<List<Category>> getAllCategories() async {
    _loader = Loader.busy;
    try {
      _categories = await _categoryRepository.getCategories();
      _loader = Loader.complete;
      notifyListeners();
      return _categories;
    } on NetworkException catch (error) {
      _loader = Loader.error;
      dataErrorMessage = error.message;
      notifyListeners();
    } on DioError catch (error) {
      _loader = Loader.error;
      handleDioError(error);
    } catch (error) {
      _loader = Loader.error;
      notifyListeners();
    }
    return _categories;
  }

  List<Category> get getCategories => _categories;

  Category get getCategory => _category;

  Future<List<Category>> getCategoriesById(String merchantId) async {
    _loader = Loader.busy;
    try {
      _categories = await _categoryRepository.getAllCategories(merchantId);
      notifyListeners();
      _loader = Loader.complete;
      return _categories;
    } on NetworkException catch (error) {
      _loader = Loader.error;
      dataErrorMessage = error.message;
      notifyListeners();
    } on DioError catch (error) {
      _loader = Loader.error;
      handleDioError(error);
    } catch (error) {
      _loader = Loader.error;
      notifyListeners();
    }
  }

  Loader get loader => _loader;

  Future<void> saveCategory(Category category) async {
   await filter(category);
  }


  Future<void> filter(Category category) {
    _selectedCategories.add(category);
  }

  List<Category> getSelectedCategories() {
    return _selectedCategories.toList();
  }
}
