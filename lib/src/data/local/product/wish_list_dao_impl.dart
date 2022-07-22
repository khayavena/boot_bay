import 'package:bootbay/src/data/local/product/wish_list_dao.dart';
import 'package:bootbay/src/model/product.dart';
import 'package:sembast/sembast.dart';

class WishListDaoImpl implements WishListDao {
  static const String folderName = "WishList";
  final _wishListStore = intMapStoreFactory.store(folderName);
  Database _database;

  WishListDaoImpl({
    required Database database,
  }) : _database = database;

  @override
  Future<List<Product>> findItems() async {
    final recordSnapshot = await _wishListStore.find(_database);
    return recordSnapshot.map((snapshot) {
      final student = Product.fromJson(snapshot.value);
      return student;
    }).toList();
  }

  @override
  Future<Product> findById(String id) async {
    final recordSnapshot = await _wishListStore.findFirst(_database,
        finder: Finder(filter: Filter.equals("id", id)));
    if (recordSnapshot == null) {
      return Product();
    }
    return Product.fromJson(recordSnapshot.value);
  }

  @override
  Future<void> insert(Product product) async {
    int b = await _wishListStore.add(_database, product.toJson());
    print('Insert status $b');
  }

  @override
  Future<void> delete(Product product) async {
    var b = await _wishListStore.delete(_database,
        finder: Finder(filter: Filter.equals("id", product.id)));
    print('Delete status $b');
  }

  @override
  Future<bool> isExist(String id) async {
    final recordSnapshot = await _wishListStore.find(_database);
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
