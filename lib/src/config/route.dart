import 'package:bootbay/src/pages/home_page.dart';
import 'package:bootbay/src/pages/product_detail_page.dart';
import 'package:bootbay/src/pages/shoping_cart_page.dart';
import 'package:bootbay/src/pages/shoping_wishlist_page.dart';
import 'package:flutter/material.dart';

class CustomRoutes {
  static String product_detail = '/detail';
  static String cart_list = '/cart';
  static String wish_list = '/wish';

  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => HomeWidget(),
      product_detail: (_) => ProductDetailPage(),
      cart_list: (_) => ShoppingCartPage(),
      wish_list: (_) => ShoppingWishListPage()
    };
  }
}
