import 'package:flutter/material.dart';
import 'package:bootbay/src/data/local/product/category_dao.dart';
import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/model/product.dart';
import 'package:sembast/sembast.dart';

class CategoryDaoImpl implements CategoryDao {
  static const String folderName = "Category";
  final _categoryStore = intMapStoreFactory.store(folderName);
  Database _database;

  CategoryDaoImpl({
    @required Database database,
  }) : _database = database;

  @override
  Future<List<Category>> findAll() async {
    final recordSnapshot = await _categoryStore.find(_database);
    return recordSnapshot.map((snapshot) {
      final student = Category.fromJson(snapshot.value);
      return student;
    }).toList();
  }

  @override
  @override
  Future<void> insertAll(List<Category> products) async {
    await _categoryStore.delete(_database);
    await _categoryStore.addAll(
        _database, products.map((e) => e.toJson()).toList());
  }

  @override
  Future<void> insertProduct(Category product) async {
    int b = await _categoryStore.add(_database, product.toJson());
    print('Category status $b');
  }

  @override
  Future<void> update(Category category) async {
    var finder = Finder(
      filter: Filter.equals('id', category.id),
    );
    int b = await _categoryStore.update(_database, category.toJson(),
        finder: finder);
    print('Category status $b');
  }

  @override
  Future<void> updateAll(List<Category> products) async {
    await _categoryStore.addAll(
        _database, products.map((e) => e.toJson()).toList());
  }

  @override
  Future<Product> findProductById(int id) {
    throw UnimplementedError();
  }
}
