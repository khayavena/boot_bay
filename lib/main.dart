import 'package:bootbay/src/config/EnvConfig.dart';
import 'package:bootbay/src/config/EnvConfigService.dart';
import 'package:bootbay/src/config/app_routing.dart';
import 'package:bootbay/src/data/local/database/database.dart';
import 'package:bootbay/src/data/local/payment/payment_dao.dart';
import 'package:bootbay/src/data/local/payment/payment_dao_Impl.dart';
import 'package:bootbay/src/data/local/product/cart_dao_impl.dart';
import 'package:bootbay/src/data/local/product/product_dao.dart';
import 'package:bootbay/src/data/local/product/product_dao_impl.dart';
import 'package:bootbay/src/data/local/product/wish_list_dao_impl.dart';
import 'package:bootbay/src/data/local/user/user_dao.dart';
import 'package:bootbay/src/data/local/user/user_dao_impl.dart';
import 'package:bootbay/src/data/remote/auth/remote_user_service.dart';
import 'package:bootbay/src/data/remote/auth/remote_user_service_Impl.dart';
import 'package:bootbay/src/data/remote/dio/dio_api_client.dart';
import 'package:bootbay/src/data/remote/mediacontent/remote_media_content_datasource_impl.dart';
import 'package:bootbay/src/data/remote/merchant/remote_merchant_data_source_impl.dart';
import 'package:bootbay/src/data/remote/payment/remote_payment_service_Impl.dart';
import 'package:bootbay/src/data/remote/product/remote_category_service_impl.dart';
import 'package:bootbay/src/data/remote/product/remote_product_service_impl.dart';
import 'package:bootbay/src/helpers/globals.dart';
import 'package:bootbay/src/helpers/network_helper.dart';
import 'package:bootbay/src/helpers/network_helper_impl.dart';
import 'package:bootbay/src/pages/category/repository/category_repository.dart';
import 'package:bootbay/src/pages/category/repository/category_repository_impl.dart';
import 'package:bootbay/src/pages/category/viewmodel/categary_view_model.dart';
import 'package:bootbay/src/pages/mediacontent/media_content_view_model.dart';
import 'package:bootbay/src/pages/merchant/repository/merchant_repository.dart';
import 'package:bootbay/src/pages/merchant/repository/merchant_repository_impl.dart';
import 'package:bootbay/src/pages/merchant/viewmodel/merchant_registration_view_model.dart';
import 'package:bootbay/src/pages/merchant/viewmodel/merchant_view_model.dart';
import 'package:bootbay/src/pages/product/repository/product_repository.dart';
import 'package:bootbay/src/pages/product/repository/product_repository_impl.dart';
import 'package:bootbay/src/pages/product/viewmodel/product_view_model.dart';
import 'package:bootbay/src/pages/shopping/repository/cart/cart_repository.dart';
import 'package:bootbay/src/pages/shopping/repository/cart/cart_repository_impl.dart';
import 'package:bootbay/src/pages/shopping/repository/wish/wish_list_repository.dart';
import 'package:bootbay/src/pages/shopping/repository/wish/wish_list_repository_impl.dart';
import 'package:bootbay/src/pages/shopping/viewmodel/cart_view_model.dart';
import 'package:bootbay/src/pages/shopping/viewmodel/wish_list_view_model.dart';
import 'package:bootbay/src/repository/mediacontent/media_content_repository.dart';
import 'package:bootbay/src/repository/mediacontent/media_content_repository_impl.dart';
import 'package:bootbay/src/repository/payment/payment_repository.dart';
import 'package:bootbay/src/repository/payment/payment_repository_impl.dart';
import 'package:bootbay/src/repository/user/user_repository.dart';
import 'package:bootbay/src/repository/user/user_repository_impl.dart';
import 'package:bootbay/src/viewmodel/UserViewModel.dart';
import 'package:bootbay/src/viewmodel/ViewModel.dart';
import 'package:bootbay/src/viewmodel/payment_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sembast/sembast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final EnvConfig devConfig = await EnvConfigServiceImpl(Flavor.DEV).getEnvConfig();
  baseUrl = devConfig.baseUrl;
  final Dio dio = DioClient.getClient(
    devConfig.baseUrl,
    devConfig.appKey,
  );

  final Database appDb = await AppDatabaseImpl.instance.database;

  final NetworkHelper networkHelper = NetworkHelperImpl();

  final RemoteUserService userService = RemoteUserServiceImpl(dio: dio);

  final PaymentDao paymentDao = PaymentDaoImpl(database: appDb);

  final PaymentRepository paymentRepository = PaymentRepositoryImpl(
    paymentDao: paymentDao,
    networkHelper: networkHelper,
    paymentService: RemotePaymentServiceImpl(dio: dio),
  );

  final UserDao userDao = UserDaoImpl(database: appDb);
  final UserRepository userRepository =
      UserRepositoryImpl(userService: userService, networkHelper: networkHelper, userDao: userDao);

  final ProductDao productDao = ProductDaoImpl(database: appDb);

  final CartRepository cartRepository =
      CartRepositoryImpl(cartDao: CartDaoImpl(database: appDb), networkHelper: networkHelper);

  final WishListRepository wishListRepository =
      WishListRepositoryImpl(wishListDao: WishListDaoImpl(database: appDb), networkHelper: networkHelper);

  final MerchantRepository merchantRepository =
      MerchantRepositoryImpl(remoteMerchantDataSource: RemoteMerchantDataSourceImpl(dioClient: dio));

  final MediaContentRepository mediaContentRepository =
      MediaContentRepositoryImpl(mediaContentDataSource: RemoteMediaContentDataSourceImpl(dio: dio));

  final ProductRepository productRepository = ProductRepositoryImpl(
    remoteProductService: RemoteProductServiceImpl(
      dio: dio,
    ),
    localProductService: productDao,
    networkHelper: networkHelper,
  );

  final CategoryRepository categoryRepository = CategoryRepositoryImpl(
    remoteProductService: RemoteCategoryServiceImpl(
      dio: dio,
    ),
    networkHelper: networkHelper,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ViewModel()),
        ChangeNotifierProvider(create: (context) => ProductViewModel(productRepository: productRepository)),
        ChangeNotifierProvider(create: (context) => CartViewModel(cartRepository: cartRepository)),
        ChangeNotifierProvider(create: (context) => WishListViewModel(wishListRepository: wishListRepository)),
        ChangeNotifierProvider(create: (context) => MerchantViewModel(merchantRepository: merchantRepository)),
        ChangeNotifierProvider(
            create: (context) => MediaContentViewModel(mediaContentRepository: mediaContentRepository)),
        ChangeNotifierProvider(
            create: (context) => MerchantRegistrationViewModel(merchantRepository: merchantRepository)),
        ChangeNotifierProvider(create: (context) => UserViewModel(userRepository: userRepository)),
        ChangeNotifierProvider(
            create: (context) =>
                PaymentViewModel(userRepository: userRepository, paymentRepository: paymentRepository)),
        ChangeNotifierProvider(create: (context) => CategoryViewModel(categoryRepository: categoryRepository)),
        Provider<Database>(create: (context) => appDb),
        Provider<ProductRepository>(create: (context) => productRepository),
        Provider<MerchantRepository>(create: (context) => merchantRepository),
        Provider<CartRepository>(create: (context) => cartRepository),
        Provider<WishListRepository>(create: (context) => wishListRepository),
        Provider<CategoryRepository>(create: (context) => categoryRepository),
        Provider<UserRepository>(create: (context) => userRepository),
        Provider<MediaContentRepository>(create: (context) => mediaContentRepository),
        Provider<NetworkHelper>(create: (context) => networkHelper),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, onGenerateRoute: AppRouting.generateRoute);
  }
}
