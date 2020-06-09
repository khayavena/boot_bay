import 'package:bootbay/src/model/product.dart';
import 'package:bootbay/src/wigets/shared/CartItem.dart';
import 'package:flutter/material.dart';

class CartListView extends StatelessWidget {
  final List<Product> cartItems;

  CartListView({
    @required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        children: cartItems
            .map((model) => CartItem(
                  model: model,
                ))
            .toList());
  }
}
