import 'package:bootbay/src/model/pay_method/model/product.dart';
import 'package:bootbay/src/wigets/cart/cart_item_widget.dart';
import 'package:flutter/material.dart';

class CartListView extends StatelessWidget {
  final List<Product> cartItems;

  CartListView({
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        children: cartItems
            .map((model) => Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: CartItemWidget(
                    model: model,
                  ),
                ))
            .toList());
  }
}
