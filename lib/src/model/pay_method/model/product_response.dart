import 'package:bootbay/src/model/pay_method/model/product.dart';

class ProductResponse {
  late Product item;
  late String message;

  ProductResponse();

  ProductResponse.fromJson(json)
      : item = Product.fromJson(json['item']),
        message = json['message'];
}
