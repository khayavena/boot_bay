import 'package:bootbay/src/model/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getAllCategories(String merchantId);

  Future<List<Category>> getCategories();

  Future<Category> addCategory(Category category);
}
