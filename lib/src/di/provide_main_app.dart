import 'package:bootbay/src/config/EnvConfig.dart';
import 'package:bootbay/src/di/boot_bay_module_locator.dart';
import 'package:bootbay/src/pages/category/repository/category_repository.dart';
import 'package:bootbay/src/pages/category/viewmodel/categary_view_model.dart';
import 'package:bootbay/src/pages/checkout/repository/payment_repository.dart';
import 'package:bootbay/src/pages/checkout/viewmodel/payment_view_model.dart';
import 'package:bootbay/src/pages/mediacontent/media_content_view_model.dart';
import 'package:bootbay/src/pages/mediacontent/media_view_model.dart';
import 'package:bootbay/src/pages/merchant/repository/merchant_repository.dart';
import 'package:bootbay/src/pages/merchant/viewmodel/merchant_registration_view_model.dart';
import 'package:bootbay/src/pages/merchant/viewmodel/merchant_view_model.dart';
import 'package:bootbay/src/pages/product/repository/product_repository.dart';
import 'package:bootbay/src/pages/product/viewmodel/product_view_model.dart';
import 'package:bootbay/src/pages/shopping/page/home_page.dart';
import 'package:bootbay/src/pages/shopping/repository/cart/cart_repository.dart';
import 'package:bootbay/src/pages/shopping/repository/wish/wish_list_repository.dart';
import 'package:bootbay/src/pages/shopping/viewmodel/cart_view_model.dart';
import 'package:bootbay/src/pages/shopping/viewmodel/wish_list_view_model.dart';
import 'package:bootbay/src/pages/user/repository/third_party_auth_repository.dart';
import 'package:bootbay/src/pages/user/repository/user_repository.dart';
import 'package:bootbay/src/repository/mediacontent/media_content_repository.dart';
import 'package:bootbay/src/pages/user/viewmodel/UserViewModel.dart';
import 'package:bootbay/src/viewmodel/ViewModel.dart';
import 'package:bootbay/src/wigets/shared/custom_drop_down.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

Future<void> provideMainApp(Flavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocator(flavor);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ViewModel()),
        ChangeNotifierProvider(create: (context) => DropDownValueChangeNotifier()),
        ChangeNotifierProvider(create: (context) => BottomNavChangeNotifier()),
        ChangeNotifierProvider(create: (context) => MediaViewModel()),
        ChangeNotifierProvider(
            create: (context) => ProductViewModel(productRepository: moduleLocator<ProductRepository>())),
        ChangeNotifierProvider(create: (context) => CartViewModel(cartRepository: moduleLocator<CartRepository>())),
        ChangeNotifierProvider(
            create: (context) => WishListViewModel(wishListRepository: moduleLocator<WishListRepository>())),
        ChangeNotifierProvider(
            create: (context) => MerchantViewModel(merchantRepository: moduleLocator<MerchantRepository>())),
        ChangeNotifierProvider(
            create: (context) =>
                MediaContentViewModel(mediaContentRepository: moduleLocator<MediaContentRepository>())),
        ChangeNotifierProvider(
            create: (context) =>
                MerchantRegistrationViewModel(merchantRepository: moduleLocator<MerchantRepository>())),
        ChangeNotifierProvider(
            create: (context) => UserViewModel(
                userRepository: moduleLocator<UserRepository>(),
                thirdPartyAuthRepository: moduleLocator<ThirdPartyAuthRepository>())),
        ChangeNotifierProvider(
            create: (context) => PaymentViewModel(
                userRepository: moduleLocator<UserRepository>(),
                paymentRepository: moduleLocator<PaymentRepository>())),
        ChangeNotifierProvider(
            create: (context) => CategoryViewModel(categoryRepository: moduleLocator<CategoryRepository>())),
      ],
      child: App(),
    ),
  );
}
