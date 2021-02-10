import 'package:bootbay/src/model/category.dart';

abstract class RemoteCategoryDataSource {
  Future<List<Category>> getAllByMerchant(String merchantId);

  Future<List<Category>> getAll();

  Future<Category> add(Category category);
}
