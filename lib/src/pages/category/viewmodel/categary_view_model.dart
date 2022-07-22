import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/network_exception.dart';
import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/pages/category/repository/category_repository.dart';
import 'package:bootbay/src/viewmodel/ViewModel.dart';
import 'package:dio/dio.dart';

class CategoryViewModel extends ViewModel {
  final CategoryRepository _categoryRepository;

  List<Category> _categories = [];
  Set<Category> _selectedCategories = Set();
  Category _category = Category();

  late String dataErrorMessage = "";

  Loader _loader = Loader.idl;

  CategoryViewModel({
    required CategoryRepository categoryRepository,
  }) : _categoryRepository = categoryRepository;

  Future<List<Category>> getAllCategories() async {
    _loader = Loader.busy;
    notifyListeners();
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
      dataErrorMessage = 'error.message';
      notifyListeners();
    }
    return _categories;
  }

  List<Category> get getCategories => _categories;

  Category get getCategory => _category;

  Future<List<Category>> getCategoriesById(String merchantId) async {
    _loader = Loader.busy;
    notifyListeners();
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
    notifyListeners();
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
