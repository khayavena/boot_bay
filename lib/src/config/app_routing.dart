import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/model/product.dart';
import 'package:bootbay/src/pages/mediacontent/MediaContentPage.dart';
import 'package:bootbay/src/pages/merchant/edit_merchant_management_page.dart';
import 'package:bootbay/src/pages/merchant/edit_merchant_options_page.dart';
import 'package:bootbay/src/pages/merchant/merchant_landing_page.dart';
import 'package:bootbay/src/pages/merchant/merchant_list_page.dart';
import 'package:bootbay/src/pages/merchant/merchant_management_list_page.dart';
import 'package:bootbay/src/pages/merchant/merchant_registration_page.dart';
import 'package:bootbay/src/pages/shopping/home_page.dart';
import 'package:bootbay/src/pages/shopping/product_detail_page.dart';
import 'package:bootbay/src/pages/shopping/shoping_cart_page.dart';
import 'package:bootbay/src/pages/shopping/shoping_wish_list_page.dart';
import 'package:bootbay/src/pages/user/auth_page.dart';
import 'package:bootbay/src/wigets/category/category_drop_down_widget.dart';
import 'package:flutter/material.dart';

class AppRouting {
  static String authPage = '/autPage';
  static String productDetail = '/detail';
  static String cartList = '/cart';
  static String wishList = '/wish';
  static String merchants = '/merchantsList';
  static String merchantLanding = '/merchantsLanding';
  static String merchantsRegistration = '/merchantsRegistration';
  static String merchantsManagementEdit = '/editMerchantManagement';
  static String merchantsManagementList = '/merchantManagementList';
  static String merchantItemCategoryList = '/merchantItemCategoryList';
  static String merchantManagementEditOptions = '/merchantManagementEditOptions';
  static String mediaContent = "/MediaContent";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeWidget());
      case '/autPage':
        return MaterialPageRoute(settings: RouteSettings(name: authPage), builder: (_) => AuthPage());
      case '/merchantsRegistration':
        if (args != null) {
          return MaterialPageRoute(
              settings: RouteSettings(name: merchantsRegistration),
              builder: (_) => MerchantRegistrationPage(
                    userId: args,
                  ));
        }
        return _errorRoute(error: 'Ensure user is logged to load MerchantRegistrationPage');
      case '/cart':
        return MaterialPageRoute(settings: RouteSettings(name: cartList), builder: (_) => ShoppingCartPage());
      case '/wish':
        return MaterialPageRoute(settings: RouteSettings(name: wishList), builder: (_) => ShoppingWishListPage());
      case '/merchantsList':
        return MaterialPageRoute(settings: RouteSettings(name: merchants), builder: (_) => MerchantListPage());
      case '/merchantManagementEditOptions':
        return MaterialPageRoute(
            settings: RouteSettings(name: merchantManagementEditOptions),
            builder: (_) => EditMerchantManagementOptionsWidget(
                  merchant: args as Merchant,
                ));
      case '/merchantManagementList':
        return MaterialPageRoute(
            settings: RouteSettings(name: merchantsManagementList),
            builder: (_) => MerchantManagementListPage(
                  userId: args,
                ));
      case '/MediaContent':
        return MaterialPageRoute(
            settings: RouteSettings(name: mediaContent), builder: (_) => MediaContentWidget(id: args));
      case '/merchantItemCategoryList':
        return MaterialPageRoute(
            settings: RouteSettings(name: merchantItemCategoryList),
            builder: (_) => CategoryDropDownWidget(merchant: args as Merchant));
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

        return _errorRoute();

      case '/editMerchantManagement':
        // Validation of correct data type
        if (args is Merchant) {
          return MaterialPageRoute(
            settings: RouteSettings(name: merchantsManagementEdit),
            builder: (_) => EditMerchantManagementPage(
              merchant: args,
            ),
          );
        }

        return _errorRoute();
      default:
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
