import 'package:bootbay/src/model/pay_method/model/product.dart';

class ProductResponse {
  final Product item;
  final String message;

  ProductResponse.fromJson(json)
      : item = Product.fromJson(json['item']),
        message = json['message'];
}
