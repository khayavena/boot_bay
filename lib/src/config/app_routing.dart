import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/model/product.dart';
import 'package:bootbay/src/pages/category/add_category_page.dart';
import 'package:bootbay/src/pages/category/edit_category_page.dart';
import 'package:bootbay/src/pages/mediacontent/media_content_page.dart';
import 'package:bootbay/src/pages/merchant/page/edit_merchant_management_page.dart';
import 'package:bootbay/src/pages/merchant/page/edit_merchant_options_page.dart';
import 'package:bootbay/src/pages/merchant/page/merchant_category_list_page.dart';
import 'package:bootbay/src/pages/merchant/page/merchant_list_page.dart';
import 'package:bootbay/src/pages/merchant/page/merchant_management_list_page.dart';
import 'package:bootbay/src/pages/merchant/page/merchant_registration_page.dart';
import 'package:bootbay/src/pages/product/page/add_product_page.dart';
import 'package:bootbay/src/pages/product/page/category_product_page.dart';
import 'package:bootbay/src/pages/product/page/edit_product_page.dart';
import 'package:bootbay/src/pages/product/page/merchant_product_page.dart';
import 'package:bootbay/src/pages/shopping/page/home_page.dart';
import 'package:bootbay/src/pages/shopping/page/product_detail_page.dart';
import 'package:bootbay/src/pages/shopping/page/shoping_cart_page.dart';
import 'package:bootbay/src/pages/shopping/page/shoping_wish_list_page.dart';
import 'package:bootbay/src/pages/user/auth_page.dart';
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
  static const String merchantCategoryList = '/merchantItemCategoryList';
  static const String merchantManagementEditOptions = '/merchantManagementEditOptions';
  static const String mediaContent = "/mediaContent";
  static const String editCategory = "/editCategory";
  static const String addCategory = "/addCategory";
  static const String addProduct = "/addProduct";
  static const String editProductPage = '/editProductPage';
  static const String editCategoryProductPage = '/editCategoryProductPage';

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
      case merchantCategoryList:
        return createRoute(merchantCategoryList, MerchantCategoryListPage(merchant: args as Merchant));
      case productDetail:
        if (args is Product) {
          return createRoute(
              productDetail,
              ProductDetailPage(
                product: args,
              ));
        }
        return _errorRoute(error: 'Failed to load product page');
      case editProductPage:
        return createRoute(
            editProductPage,
            EditProductPage(
              product: args,
            ));

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
        Map map = args;
        Category category = map['category'];
        Merchant merchant = map['merchant'];
        return createRoute(
            editCategory,
            EditCategoryPage(
              category: category,
              merchant: merchant,
            ));
      case editCategoryProductPage:
        return createRoute(
            editCategoryProductPage,
            CategoryProductPage(
              category: args as Category,
            ));
      case addProduct:
        Map map = args;
        Category category = map['category'] ?? null;
        Merchant merchant = map['merchant'];
        return createRoute(
            editCategory,
            AddProductPage(
              category: category,
              merchant: merchant,
            ));
      case addCategory:
        return createRoute(
            addCategory,
            AddCategoryPage(
              merchant: args as Merchant,
            ));
      case addCategory:
        return createRoute(
            addCategory,
            AddCategoryPage(
              merchant: args as Merchant,
            ));

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
