import 'package:bootbay/src/pages/home_page.dart';
import 'package:bootbay/src/pages/product_detail.dart';
import 'package:bootbay/src/pages/shoping_cart_page.dart';
import 'package:flutter/material.dart';

class CustomRoutes {
  static String product_detail = '/detail';
  static String cart_list = '/cart';

  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => HomeWidget(),
      product_detail: (_) => ProductDetailPage(),
      cart_list: (_) => ShoppingCartPage()
    };
  }
}
