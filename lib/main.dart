import 'package:bootbay/src/config/EnvConfig.dart';
import 'package:bootbay/src/config/EnvConfigService.dart';
import 'package:bootbay/src/config/route.dart';
import 'package:bootbay/src/data/local/database/database.dart';
import 'package:bootbay/src/data/local/payment/payment_dao.dart';
import 'package:bootbay/src/data/local/payment/payment_dao_Impl.dart';
import 'package:bootbay/src/data/local/product/product_dao.dart';
import 'package:bootbay/src/data/local/product/product_dao_impl.dart';
import 'package:bootbay/src/data/local/user/user_dao.dart';
import 'package:bootbay/src/data/local/user/user_dao_impl.dart';
import 'package:bootbay/src/data/remote/auth/remote_user_service.dart';
import 'package:bootbay/src/data/remote/auth/remote_user_service_Impl.dart';
import 'package:bootbay/src/data/remote/dio/dio_api_client.dart';
import 'package:bootbay/src/data/remote/payment/remote_payment_service_Impl.dart';
import 'package:bootbay/src/data/remote/product/remote_category_service_impl.dart';
import 'package:bootbay/src/data/remote/product/remote_product_service_impl.dart';
import 'package:bootbay/src/helpers/network_helper.dart';
import 'package:bootbay/src/helpers/network_helper_impl.dart';
import 'package:bootbay/src/pages/auth_page.dart';
import 'package:bootbay/src/pages/product_detail.dart';
import 'package:bootbay/src/repository/category_repository.dart';
import 'package:bootbay/src/repository/category_repository_impl.dart';
import 'package:bootbay/src/repository/payment_repository.dart';
import 'package:bootbay/src/repository/payment_repository_impl.dart';
import 'package:bootbay/src/repository/product_repository.dart';
import 'package:bootbay/src/repository/product_repository_impl.dart';
import 'package:bootbay/src/repository/user_repository.dart';
import 'package:bootbay/src/repository/user_repository_impl.dart';
import 'package:bootbay/src/viewmodel/CategaryViewModel.dart';
import 'package:bootbay/src/viewmodel/PaymentViewModel.dart';
import 'package:bootbay/src/viewmodel/ProductViewModel.dart';
import 'package:bootbay/src/viewmodel/UserViewModel.dart';
import 'package:bootbay/src/viewmodel/ViewModel.dart';
import 'package:bootbay/src/wigets/custom_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sembast/sembast.dart';

import 'src/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final EnvConfig devConfig =
      await EnvConfigServiceImpl(Flavor.DEV).getEnvConfig();

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
  final UserRepository userRepository = UserRepositoryImpl(
      userService: userService, networkHelper: networkHelper, userDao: userDao);

  final ProductDao productDao = ProductDaoImpl(database: appDb);

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
        ChangeNotifierProvider(
            create: (context) =>
                ProductViewModel(productRepository: productRepository)),
        ChangeNotifierProvider(
            create: (context) => UserViewModel(userRepository: userRepository)),
        ChangeNotifierProvider(
            create: (context) => PaymentViewModel(
                userRepository: userRepository,
                paymentRepository: paymentRepository)),
        ChangeNotifierProvider(
            create: (context) =>
                CategoryViewModel(categoryRepository: categoryRepository)),
        Provider<Database>(create: (context) => appDb),
        Provider<ProductRepository>(create: (context) => productRepository),
        Provider<CategoryRepository>(create: (context) => categoryRepository),
        Provider<UserRepository>(create: (context) => userRepository),
        Provider<NetworkHelper>(create: (context) => networkHelper),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce ',
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.muliTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: Routes.getRoute(),
      // ignore: missing_return
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[1].contains('detail')) {
          return AnimatedRoute<bool>(
              builder: (BuildContext context) => ProductDetailPage());
        }
        if (pathElements[1].contains('login')) {
          return AnimatedRoute<bool>(
              builder: (BuildContext context) => AuthPage());
        }
      },
    );
  }
}
