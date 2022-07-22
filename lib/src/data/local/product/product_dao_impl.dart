import 'package:bootbay/src/data/local/product/product_dao.dart';
import 'package:bootbay/src/model/product.dart';
import 'package:sembast/sembast.dart';

class ProductDaoImpl implements ProductDao {
  static const String folderName = "Products";
  final _productStore = intMapStoreFactory.store(folderName);
  Database _database;

  ProductDaoImpl({
    required Database database,
  }) : _database = database;

  @override
  Future<List<Product>> findAllProducts() async {
    final recordSnapshot = await _productStore.find(_database);
    return recordSnapshot.map((snapshot) {
      final student = Product.fromJson(snapshot.value);
      return student;
    }).toList();
  }

  @override
  Future<Product> findProductById(String id) async {
    final recordSnapshot = await _productStore.findFirst(_database,
        finder: Finder(filter: Filter.byKey(id)));
    return Product.fromJson(recordSnapshot?.value ?? {});
  }

  @override
  Future<void> insertAll(List<Product> products) async {
    await _productStore.delete(_database);
    await _productStore.addAll(
        _database, products.map((e) => e.toJson()).toList());
  }

  @override
  Future<void> insertProduct(Product product) async {
    int b = await _productStore.add(_database, product.toJson());
    print('Product status $b');
  }

  @override
  Future<void> updateAll(List<Product> products) async {
    await _productStore.addAll(
        _database, products.map((e) => e.toJson()).toList());
    return null;
  }

  @override
  Future<void> delete(Product product) async {
    var b = await _productStore.delete(_database,
        finder: Finder(filter: Filter.byKey(product.id)));
    print('Delete status $b');
  }
}
