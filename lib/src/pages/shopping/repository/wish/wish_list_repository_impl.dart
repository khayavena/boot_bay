import 'package:bootbay/src/data/local/product/wish_list_dao.dart';
import 'package:bootbay/src/helpers/network_helper.dart';
import 'package:bootbay/src/model/product.dart';
import 'package:bootbay/src/pages/shopping/repository/wish/wish_list_repository.dart';

class WishListRepositoryImpl implements WishListRepository {
  WishListDao _wishListDao;
  NetworkHelper _networkHelper;

  WishListRepositoryImpl(
      {required WishListDao wishListDao, required NetworkHelper networkHelper})
      : _wishListDao = wishListDao,
        _networkHelper = networkHelper;

  @override
  Future<void> delete(Product product) {
    return _wishListDao.delete(product);
  }

  @override
  Future<List<Product>> findItems() {
    return _wishListDao.findItems();
  }

  @override
  Future<Product> findById(String id) {
    return _wishListDao.findById(id);
  }

  @override
  Future<void> insert(Product product) {
    return _wishListDao.insert(product);
  }

  @override
  Future<bool> isExist(String id) {
    return _wishListDao.isExist(id);
  }
}
