import 'package:bootbay/res.dart';
import 'package:bootbay/src/config/app_routing.dart';
import 'package:bootbay/src/helpers/ResColor.dart';
import 'package:flutter/material.dart';

class CustomAppBar {
  final String title;

  CustomAppBar(this.title);

  static AppBar build(String title, BuildContext context) {
    return AppBar(
      backgroundColor: primaryWhite,
      bottomOpacity: 0.0,
      elevation: 0.0,
      title: Text(
        title,
        style: TextStyle(
          color: Color(0xff333333),
          fontSize: 15,
          fontFamily: 'SFProText',
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: <Widget>[
        IconButton(icon: ImageIcon(AssetImage(Res.search_ic)), color: primaryBlackColor, onPressed: () {}),
        Container(
          child: IconButton(
              icon: ImageIcon(AssetImage(Res.cart_ic)),
              color: primaryBlackColor,
              onPressed: () {
                Navigator.of(context).pushNamed(AppRouting.cartList);
              }),
        )
      ],
      leading: IconButton(icon: ImageIcon(AssetImage(Res.leading_icon)), color: primaryBlackColor, onPressed: () {}),
      centerTitle: true,
    );
  }
}
