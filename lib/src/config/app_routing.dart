import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/model/product.dart';
import 'package:bootbay/src/pages/category/AddNewCategoryPage.dart';
import 'package:bootbay/src/pages/category/EditCategoryPage.dart';
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
import 'package:bootbay/src/wigets/category/category_list_view_widget.dart';
import 'package:flutter/material.dart';

class AppRouting {
  static const String authPage = '/autPage';
  static const String productDetail = '/detail';
  static const String cartList = '/cart';
  static const String wishList = '/wish';
  static const String merchantList = '/merchantsList';
  static const String merchantLanding = '/merchantsLanding';
  static const String merchantsRegistration = '/merchantsRegistration';
  static const String merchantsManagementEdit = '/editMerchantManagement';
  static const String merchantsManagementList = '/merchantManagementList';
  static const String merchantItemCategoryList = '/merchantItemCategoryList';
  static const String merchantManagementEditOptions = '/merchantManagementEditOptions';
  static const String mediaContent = "/mediaContent";
  static const String editCategory = "/editCategory";
  static const String addCategory = "/addCategory";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return createRoute('/', HomeWidget());
      case authPage:
        return createRoute(authPage, AuthPage());
      case merchantsRegistration:
        if (args != null) {
          return createRoute(
              merchantsRegistration,
              MerchantRegistrationPage(
                userId: args,
              ));
        }
        return _errorRoute(error: 'Ensure user is logged to load $merchantsRegistration');
      case cartList:
        return createRoute(cartList, ShoppingCartPage());
      case wishList:
        return createRoute(wishList, ShoppingWishListPage());
      case merchantList:
        return createRoute(merchantList, MerchantListPage());
      case merchantManagementEditOptions:
        return createRoute(
            merchantManagementEditOptions,
            EditMerchantManagementOptionsWidget(
              merchant: args as Merchant,
            ));
      case merchantsManagementList:
        return createRoute(
            merchantsManagementList,
            MerchantManagementListPage(
              userId: args,
            ));
      case mediaContent:
        return createRoute(mediaContent, MediaContentWidget(id: args));
      case merchantItemCategoryList:
        return createRoute(merchantItemCategoryList, CategoryListViewWidget(merchant: args as Merchant));
      case productDetail:
        if (args is Product) {
          return createRoute(
              productDetail,
              ProductDetailPage(
                product: args,
              ));
        }
        return _errorRoute(error: 'Failed to load product page');
      case merchantLanding:
        // Validation of correct data type
        if (args is Merchant) {
          return createRoute(
              merchantLanding,
              MerchantLandingPage(
                merchant: args,
              ));
        }

        return _errorRoute();

      case merchantsManagementEdit:
        if (args is Merchant) {
          return createRoute(
              merchantsManagementEdit,
              EditMerchantManagementPage(
                merchant: args,
              ));
        }

        return _errorRoute();
      case editCategory:
        Map map = args ;
        Category category = map['category'] ;
        Merchant merchant = map['merchant'] ;
        return createRoute(
            editCategory,
            EditCategoryPage(
              category: category,
              merchant: merchant,
            ));

      case addCategory:
        if (args != null && args is Merchant) {
          return createRoute(
              addCategory,
              AddNewCategoryPage(
                merchant: args,
              ));
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

  static Route createRoute(String routeName, Widget widget) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => widget,
    );
  }
}
