import 'package:bootbay/src/model/category.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/model/product.dart';
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

class AppRouting {
  static const String merchant_portal_page = '/MerchantPortalPage';
  static const String productDetail = '/productDetailPage';
  static const String cartList = '/cartPage';
  static const String wishList = '/wishPage';
  static const String merchantList = '/merchantsListPage';
  static const String merchantLanding = '/merchantsLandingPage';
  static const String merchantsRegistration = '/merchantsRegistrationPage';
  static const String merchantsManagementEdit = '/editMerchantManagementPage';
  static const String merchantsManagementList = '/merchantManagementListPage';
  static const String merchantCategoryList = '/merchantItemCategoryListPage';
  static const String merchantManagementEditOptions =
      '/merchantManagementEditOptionsPage';
  static const String editCategory = "/editCategoryPage";
  static const String addCategory = "/addCategoryPage";
  static const String addProduct = "/addProductPage";
  static const String editProductPage = '/editProductPage';
  static const String editCategoryProductPage = '/editCategoryProductPage';
  static const String loginPage = '/loginPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return createRoute('/', HomeBottomNavPage());
      case loginPage:
        return createRoute(loginPage, LoginDialogPage());
      case merchant_portal_page:
        return createRoute(merchant_portal_page, MerchantPortalPage());
      case merchantsRegistration:
        return createRoute(merchantsRegistration, MerchantRegistrationPage());

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
              userId: args as String,
            ));

      case merchantCategoryList:
        return createRoute(merchantCategoryList,
            MerchantCategoryListPage(merchant: args as Merchant));
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
              product: args as Product,
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
        Map map = args as Map;
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
        Map map = args as Map;
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
