import 'package:bootbay/src/model/pay_method/model/product.dart';
import 'package:bootbay/src/wigets/wish/wish_item_widget.dart';
import 'package:flutter/material.dart';

class WishListView extends StatelessWidget {
  final List<Product> wishItems;

  WishListView({
    required this.wishItems,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        children: wishItems
            .map((model) => Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: WishItemWidget(
                    model: model,
                  ),
                ))
            .toList());
  }
}
