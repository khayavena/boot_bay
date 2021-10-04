import 'package:bootbay/src/model/product.dart';

class ProductResponse {
  final Product item;
  final String message;

  ProductResponse.fromJson(json)
      : item = Product.fromJson(json),
        message = json['message'];
}
