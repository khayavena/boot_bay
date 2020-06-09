import 'package:flutter/material.dart';
import 'package:bootbay/src/pages/main_page.dart';
import 'package:bootbay/src/pages/product_detail.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => MainPage(),
      '/detail': (_) => ProductDetailPage()
    };
  }
}
