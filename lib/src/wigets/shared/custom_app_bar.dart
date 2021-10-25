import 'package:bootbay/res.dart';
import 'package:bootbay/src/config/app_routing.dart';
import 'package:bootbay/src/helpers/ResColor.dart';
import 'package:bootbay/src/helpers/ResFont.dart';
import 'package:bootbay/src/pages/shopping/viewmodel/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          color: primaryBlackColor,
          fontSize: 12,
          fontWeight: largeFont,
          fontStyle: FontStyle.normal,
          letterSpacing: -0.6400000000000001,
        ),
      ),
      actions: <Widget>[
        IconButton(icon: ImageIcon(AssetImage(Res.search_ic)), color: primaryBlackColor, onPressed: () {}),
        Container(
          width: 50,
          height: 50,
          child: Consumer<CartViewModel>(builder: (context, CartViewModel vw, Widget child) {
            return Stack(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  child: IconButton(
                      icon: ImageIcon(AssetImage(Res.cart_ic)),
                      color: primaryBlackColor,
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRouting.cartList);
                      }),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "${vw.cartItems.length}",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: mediumFont,
                    ),
                  ),
                )
              ],
            );
          }),
        )
      ],
      leading: IconButton(icon: ImageIcon(AssetImage(Res.leading_icon)), color: primaryBlackColor, onPressed: () {}),
      centerTitle: true,
    );
  }
}
