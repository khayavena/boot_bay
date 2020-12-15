import 'package:bootbay/src/model/merchant.dart';
import 'package:bootbay/src/model/product.dart';
import 'package:bootbay/src/pages/auth_page.dart';
import 'package:bootbay/src/pages/home_page.dart';
import 'package:bootbay/src/pages/merchant/merchant_landing_page.dart';
import 'package:bootbay/src/pages/merchant/merchant_list_page.dart';
import 'package:bootbay/src/pages/product_detail_page.dart';
import 'package:bootbay/src/pages/shoping_cart_page.dart';
import 'package:bootbay/src/pages/shoping_wish_list_page.dart';
import 'package:flutter/material.dart';

class AppRouting {
  static String authPage = '/autPage';
  static String productDetail = '/detail';
  static String cartList = '/cart';
  static String wishList = '/wish';
  static String merchants = '/merchantsList';
  static String merchantLanding = '/merchantsLanding';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeWidget());
      case '/autPage':
        return MaterialPageRoute(settings: RouteSettings(name: authPage), builder: (_) => AuthPage());
      case '/cart':
        return MaterialPageRoute(settings: RouteSettings(name: cartList), builder: (_) => ShoppingCartPage());
      case '/wish':
        return MaterialPageRoute(settings: RouteSettings(name: wishList), builder: (_) => ShoppingWishListPage());
      case '/merchantsList':
        return MaterialPageRoute(settings: RouteSettings(name: merchants), builder: (_) => MerchantListPage());
      case '/detail':
        if (args is Product) {
          return MaterialPageRoute(
              settings: RouteSettings(name: productDetail),
              builder: (_) => ProductDetailPage(
                    product: args,
                  ));
        }
        return _errorRoute(error: 'Failed to load product page');
      case '/merchantsLanding':
        // Validation of correct data type
        if (args is Merchant) {
          return MaterialPageRoute(
            settings: RouteSettings(name: merchantLanding),
            builder: (_) => MerchantLandingPage(
              merchant: args,
            ),
          );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute({String error = 'Page not found'}) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text(error),
        ),
      );
    });
  }
}
