import 'package:bootbay/src/data/remote/product/remote_category_service.dart';
import 'package:bootbay/src/model/category.dart';
import 'package:dio/dio.dart';

class RemoteCategoryServiceImpl implements RemoteCategoryDataSource {
  Dio _dio;

  RemoteCategoryServiceImpl({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<Category> add(Category category) async {
    Response response =
        await _dio.post('/api/category/add', data: category.toJson());
    return Category.fromJson(response.data);
  }

  @override
  Future<List<Category>> getAllByMerchant(String merchantId) async {
    Response response = await _dio.get('/api/category/query/$merchantId');
    return List<Category>.from(
        response.data.map((json) => Category.fromJson(json)));
  }

  @override
  Future<List<Category>> getAll() async {
    Response response = await _dio.get('/api/category/all');
    return List<Category>.from(
        response.data.map((json) => Category.fromJson(json)));
  }
}
