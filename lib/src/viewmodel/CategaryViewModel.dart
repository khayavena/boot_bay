import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/network_exception.dart';
import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/repository/category/category_repository.dart';
import 'package:bootbay/src/viewmodel/MediaContentViewModel.dart';
import 'package:bootbay/src/viewmodel/ViewModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CategoryViewModel extends ViewModel {
  final CategoryRepository _categoryRepository;
  final MediaContentViewModel _contentViewModel;

  List<Category> _categories = [];
  Set<Category> _selectedCategories = Set();
  Category _category = Category();

  String dataErrorMessage;

  Loader _loader = Loader.idl;

  CategoryViewModel(
      {@required CategoryRepository categoryRepository, @required MediaContentViewModel mediaContentViewModel})
      : _categoryRepository = categoryRepository,
        _contentViewModel = mediaContentViewModel;

  Future<List<Category>> getAllCategories() async {
    _loader = Loader.busy;
    try {
      _categories = await _categoryRepository.getAll();
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
      _categories = await _categoryRepository.getAllByMerchant(merchantId);

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
    return _categories;
  }

  Future<Category> saveCategory(Category category) async {
    _loader = Loader.busy;
    var response = await _categoryRepository.add(category);
    _category = response;
    _loader = Loader.complete;
    notifyListeners();
    return response;
  }

  Future<void> filter(Category category) async {
    _selectedCategories.add(category);
    notifyListeners();
  }

  List<Category> getSelectedCategories() {
    return _selectedCategories.toList();
  }

  Loader get loader => _loader;
}
