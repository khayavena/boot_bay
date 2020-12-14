import 'package:bootbay/res.dart';
import 'package:bootbay/src/config/app_routing.dart';
import 'package:flutter/material.dart';

class CartAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(AppRouting.cartList);
        },
        child: Container(width: 16, height: 16, child: Image.asset(Res.cart_ic)));
  }
}
