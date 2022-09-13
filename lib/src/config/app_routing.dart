import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/model/pay_method/model/product.dart';
import 'package:bootbay/src/pages/category/add_category_page.dart';
import 'package:bootbay/src/pages/category/edit_category_page.dart';
import 'package:bootbay/src/pages/merchant/page/edit_merchant_management_page.dart';
import 'package:bootbay/src/pages/merchant/page/edit_merchant_options_page.dart';
import 'package:bootbay/src/pages/merchant/page/merchant_category_list_page.dart';
import 'package:bootbay/src/pages/merchant/page/merchant_list_page.dart';
import 'package:bootbay/src/pages/merchant/page/merchant_management_list_page.dart';
import 'package:bootbay/src/pages/merchant/page/merchant_portal_page.dart';
import 'package:bootbay/src/pages/merchant/page/merchant_registration_page.dart';
import 'package:bootbay/src/pages/product/page/add_product_page.dart';
import 'package:bootbay/src/pages/product/page/category_product_page.dart';
import 'package:bootbay/src/pages/product/page/edit_product_page.dart';
import 'package:bootbay/src/pages/product/page/merchant_product_page.dart';
import 'package:bootbay/src/pages/shopping/page/home_page.dart';
import 'package:bootbay/src/pages/shopping/page/product_detail_page.dart';
import 'package:bootbay/src/pages/shopping/page/shoping_cart_page.dart';
import 'package:bootbay/src/pages/shopping/page/shoping_wish_list_page.dart';
import 'package:bootbay/src/pages/user/login_page.dart';
import 'package:flutter/material.dart';

import '../pages/entityaddress/page/entity_address_page.dart';
import '../pages/mediacontent/page/content_page.dart';

class AppRouting {
  static const String merchantPortalPage = '/MerchantPortalPage';
  static const String productDetailPage = '/productDetailPage';
  static const String cartListPage = '/cartPage';
  static const String wishListPage = '/wishPage';
  static const String merchantListPage = '/merchantsListPage';
  static const String merchantLandingPage = '/merchantsLandingPage';
  static const String merchantsRegistrationPage = '/merchantsRegistrationPage';
  static const String merchantsManagementEditPage =
      '/editMerchantManagementPage';
  static const String merchantsManagementListPage =
      '/merchantManagementListPage';
  static const String merchantCategoryListPage =
      '/merchantItemCategoryListPage';
  static const String merchantManagementEditOptionsPage =
      '/merchantManagementEditOptionsPage';
  static const String editCategoryPage = "/editCategoryPage";
  static const String addCategoryPage = "/addCategoryPage";
  static const String addProductPage = "/addProductPage";
  static const String editProductPage = '/editProductPage';
  static const String editCategoryProductPage = '/editCategoryProductPage';
  static const String loginPage = '/loginPage';
  static const String addImagePage = '/addImage';
  static const String addAddressPage = '/entityAddressPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return createRoute('/', HomeBottomNavPage());
      case loginPage:
        return createRoute(loginPage, LoginDialogPage());
      case merchantPortalPage:
        return createRoute(merchantPortalPage, MerchantPortalPage());
      case merchantsRegistrationPage:
        return createRoute(
            merchantsRegistrationPage, MerchantRegistrationPage());
      case cartListPage:
        return createRoute(cartListPage, ShoppingCartPage());
      case wishListPage:
        return createRoute(wishListPage, ShoppingWishListPage());
      case merchantListPage:
        return createRoute(merchantListPage, MerchantListPage());
      case merchantManagementEditOptionsPage:
        return createRoute(merchantManagementEditOptionsPage,
            EditMerchantManagementOptionsWidget(merchant: args as Merchant));
      case merchantsManagementListPage:
        return createRoute(merchantsManagementListPage,
            MerchantManagementListPage(userId: args as String));
      case merchantCategoryListPage:
        return createRoute(merchantCategoryListPage,
            MerchantCategoryListPage(merchant: args as Merchant));
      case productDetailPage:
        if (args is Product) {
          return createRoute(
              productDetailPage, ProductDetailPage(product: args));
        }
        return _errorRoute(error: 'Failed to load product page');
      case editProductPage:
        return createRoute(
            editProductPage, EditProductPage(product: args as Product));

      case merchantLandingPage:
        if (args is Merchant) {
          return createRoute(
              merchantLandingPage, MerchantLandingPage(merchant: args));
        }
        return _errorRoute();
      case merchantsManagementEditPage:
        if (args is Merchant) {
          return createRoute(merchantsManagementEditPage,
              EditMerchantManagementPage(merchant: args));
        }
        return _errorRoute();
      case editCategoryPage:
        Map map = args as Map;
        Category category = map['category'];
        Merchant merchant = map['merchant'];
        return createRoute(editCategoryPage,
            EditCategoryPage(category: category, merchant: merchant));
      case editCategoryProductPage:
        return createRoute(editCategoryProductPage,
            CategoryProductPage(category: args as Category));
      case addProductPage:
        Map map = args as Map;
        Category? category = map['category'] ?? null;
        Merchant merchant = map['merchant'];
        return createRoute(editCategoryPage,
            AddProductPage(category: category, merchant: merchant));
      case addCategoryPage:
        return createRoute(
            addCategoryPage, AddCategoryPage(merchant: args as Merchant));
      case addImagePage:
        Map map = args as Map;
        return createRoute(addImagePage,
            ContentPage(id: map["id"], type: map["type"], name: map["name"]));
      case addAddressPage:
        Map map = args as Map;
        return createRoute(
            addAddressPage,
            EntityAddressPage(
                id: map["id"], type: map["type"], name: map["name"]));
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
