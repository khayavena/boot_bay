import 'package:bootbay/src/data/remote/product/remote_category_service.dart';
import 'package:bootbay/src/helpers/network_exception.dart';
import 'package:bootbay/src/helpers/network_helper.dart';
import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/pages/category/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  RemoteCategoryDataSource _remoteCategoryService;
  NetworkHelper _networkHelper;

  CategoryRepositoryImpl({
    required RemoteCategoryDataSource remoteProductService,
    required NetworkHelper networkHelper,
  })  : _remoteCategoryService = remoteProductService,
        _networkHelper = networkHelper;

  @override
  Future<Category> add(Category category) async {
    if (await _networkHelper.isNotConnected()) {
      throw NetworkException();
    }
    return _remoteCategoryService.add(category);
  }

  @override
  Future<List<Category>> getAllByMerchant(String merchantId) async {
    if (await _networkHelper.isNotConnected()) {
      throw NetworkException();
    }
    return _remoteCategoryService.getAllByMerchant(merchantId);
  }

  @override
  Future<List<Category>> getAll() async {
    if (await _networkHelper.isNotConnected()) {
      throw NetworkException();
    }
    return _remoteCategoryService.getAll();
  }
}
