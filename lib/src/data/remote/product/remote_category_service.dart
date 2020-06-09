import 'package:bootbay/src/model/category.dart';

abstract class RemoteCategoryService {
  Future<List<Category>> getAllCategories(String merchantId);

  Future<List<Category>> getCategories();

  Future<Category> addCategory(Category category);
}
