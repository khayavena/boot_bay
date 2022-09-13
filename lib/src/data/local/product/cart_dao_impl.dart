import 'package:bootbay/src/model/pay_method/model/product.dart';
import 'package:sembast/sembast.dart';

import 'cart_dao.dart';

class CartDaoImpl implements CartDao {
  static const String folderName = "Cart";
  final _productStore = intMapStoreFactory.store(folderName);
  Database _database;

  CartDaoImpl({
    required Database database,
  }) : _database = database;

  @override
  Future<List<Product>> findCartItems() async {
    final recordSnapshot = await _productStore.find(_database);
    return recordSnapshot.map((snapshot) {
      final student = Product.fromJson(snapshot.value);
      return student;
    }).toList();
  }

  @override
  Future<Product> findProductById(String id) async {
    final recordSnapshot = await _productStore.findFirst(_database,
        finder: Finder(filter: Filter.equals("id", id)));
    if (recordSnapshot == null) {
      return Product();
    }
    return Product.fromJson(recordSnapshot.value);
  }

  @override
  Future<void> insertProduct(Product product) async {
    int b = await _productStore.add(_database, product.toJson());
    print('Insert status $b');
  }

  @override
  Future<void> delete(Product product) async {
    var b = await _productStore.delete(_database,
        finder: Finder(filter: Filter.equals("id", product.id)));
    print('Delete status $b');
  }

  @override
  Future<bool> isExist(String id) async {
    final recordSnapshot = await _productStore.find(_database);
    var list = recordSnapshot.map((snapshot) {
      final student = Product.fromJson(snapshot.value);
      return student;
    }).toList();
    bool exist = false;
    list.forEach((element) {
      if (element.id == id) {
        exist = true;
      }
    });
    return exist;
  }
}
