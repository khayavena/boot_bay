import 'package:bootbay/src/config/EnvConfig.dart';
import 'package:bootbay/src/config/EnvConfigService.dart';
import 'package:bootbay/src/config/env_config_service.dart';
import 'package:bootbay/src/data/local/database/database.dart';
import 'package:bootbay/src/data/local/payment/payment_dao.dart';
import 'package:bootbay/src/data/local/payment/payment_dao_Impl.dart';
import 'package:bootbay/src/data/local/product/cart_dao.dart';
import 'package:bootbay/src/data/local/product/cart_dao_impl.dart';
import 'package:bootbay/src/data/local/product/product_dao.dart';
import 'package:bootbay/src/data/local/product/product_dao_impl.dart';
import 'package:bootbay/src/data/local/product/wish_list_dao.dart';
import 'package:bootbay/src/data/local/product/wish_list_dao_impl.dart';
import 'package:bootbay/src/data/local/user/user_dao.dart';
import 'package:bootbay/src/data/local/user/user_dao_impl.dart';
import 'package:bootbay/src/data/remote/auth/remote_user_service.dart';
import 'package:bootbay/src/data/remote/auth/remote_user_service_Impl.dart';
import 'package:bootbay/src/data/remote/dio/dio_api_client.dart';
import 'package:bootbay/src/data/remote/mediacontent/remote_media_content_datasource.dart';
import 'package:bootbay/src/data/remote/mediacontent/remote_media_content_datasource_impl.dart';
import 'package:bootbay/src/data/remote/merchant/remote_merchant_data_source.dart';
import 'package:bootbay/src/data/remote/merchant/remote_merchant_data_source_impl.dart';
import 'package:bootbay/src/data/remote/payment/remote_payment_service.dart';
import 'package:bootbay/src/data/remote/payment/remote_payment_service_Impl.dart';
import 'package:bootbay/src/data/remote/product/remote_category_service.dart';
import 'package:bootbay/src/data/remote/product/remote_category_service_impl.dart';
import 'package:bootbay/src/data/remote/product/remote_product_service.dart';
import 'package:bootbay/src/data/remote/product/remote_product_service_impl.dart';
import 'package:bootbay/src/helpers/globals.dart';
import 'package:bootbay/src/helpers/network_helper.dart';
import 'package:bootbay/src/helpers/network_helper_impl.dart';
import 'package:bootbay/src/pages/category/repository/category_repository.dart';
import 'package:bootbay/src/pages/category/repository/category_repository_impl.dart';
import 'package:bootbay/src/pages/merchant/repository/merchant_repository.dart';
import 'package:bootbay/src/pages/merchant/repository/merchant_repository_impl.dart';
import 'package:bootbay/src/pages/product/repository/product_repository.dart';
import 'package:bootbay/src/pages/product/repository/product_repository_impl.dart';
import 'package:bootbay/src/pages/shopping/repository/cart/cart_repository.dart';
import 'package:bootbay/src/pages/shopping/repository/cart/cart_repository_impl.dart';
import 'package:bootbay/src/pages/shopping/repository/wish/wish_list_repository.dart';
import 'package:bootbay/src/pages/shopping/repository/wish/wish_list_repository_impl.dart';
import 'package:bootbay/src/repository/mediacontent/media_content_repository.dart';
import 'package:bootbay/src/repository/mediacontent/media_content_repository_impl.dart';
import 'package:bootbay/src/repository/payment/payment_repository.dart';
import 'package:bootbay/src/repository/payment/payment_repository_impl.dart';
import 'package:bootbay/src/repository/user/firebase_auth_repository.dart';
import 'package:bootbay/src/repository/user/firebase_auth_repository_impl.dart';
import 'package:bootbay/src/repository/user/user_repository.dart';
import 'package:bootbay/src/repository/user/user_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sembast/sembast.dart';

GetIt _locator = GetIt.instance;

GetIt get moduleLocator => _locator;

Future<void> setupLocator(Flavor flavor) async {
  var config = await EnvConfigServiceImpl(flavor).getEnvConfig();
  final Database database = await AppDatabaseImpl.instance.database;
  baseUrl = config.baseUrl;
  final dio = DioClient.getClient(
    config.baseUrl,
    config.appKey,
  );
  _setEnvAndUtils(flavor);
  _setUpDatabase(database);
  _setUpRemoteServices(dio);
  _setRepositories(dio);
  _setUpAuthentication();
}

void _setUpAuthentication() {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  moduleLocator.registerLazySingleton<ThirdPartyAuthRepository>(() => ThirdPartyAuthRepositoryImpl(
      repository: moduleLocator<UserRepository>(), firebaseAuth: auth, googleSignIn: _googleSignIn));
}

void _setUpRemoteServices(dio) async {
  moduleLocator.registerLazySingleton<Dio>(() => dio);

  moduleLocator.registerLazySingleton<RemoteUserService>(() => RemoteUserServiceImpl(dio: dio));

  moduleLocator.registerLazySingleton<RemoteMerchantDataSource>(() => RemoteMerchantDataSourceImpl(dioClient: dio));

  moduleLocator.registerLazySingleton<RemoteProductService>(() => RemoteProductServiceImpl(dio: dio));

  moduleLocator.registerLazySingleton<RemoteMediaContentDataSource>(() => RemoteMediaContentDataSourceImpl(dio: dio));

  moduleLocator.registerLazySingleton<RemoteCategoryDataSource>(() => RemoteCategoryServiceImpl(dio: dio));

  moduleLocator.registerLazySingleton<RemotePaymentService>(() => RemotePaymentServiceImpl(dio: dio));
}

void _setUpDatabase(database) async {
  moduleLocator.registerLazySingleton<Database>(() => database);

  moduleLocator.registerLazySingleton<UserDao>(() => UserDaoImpl(database: moduleLocator<Database>()));

  moduleLocator.registerLazySingleton<ProductDao>(() => ProductDaoImpl(database: moduleLocator<Database>()));

  moduleLocator.registerLazySingleton<CartDao>(() => CartDaoImpl(database: moduleLocator<Database>()));

  moduleLocator.registerLazySingleton<WishListDao>(() => WishListDaoImpl(database: moduleLocator<Database>()));

  moduleLocator.registerLazySingleton<PaymentDao>(() => PaymentDaoImpl(database: moduleLocator<Database>()));
}

void _setEnvAndUtils(Flavor flavor) async {
  moduleLocator.registerLazySingleton<EnvConfigService>(() => EnvConfigServiceImpl(flavor));
  moduleLocator.registerLazySingleton<NetworkHelper>(() => NetworkHelperImpl());
}

void _setRepositories(dio) {
  moduleLocator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      userService: moduleLocator<RemoteUserService>(),
      userDao: moduleLocator<UserDao>(),
      networkHelper: moduleLocator<NetworkHelper>(),
    ),
  );

  moduleLocator.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(cartDao: moduleLocator<CartDao>(), networkHelper: moduleLocator<NetworkHelper>()));

  moduleLocator.registerLazySingleton<WishListRepository>(() =>
      WishListRepositoryImpl(wishListDao: moduleLocator<WishListDao>(), networkHelper: moduleLocator<NetworkHelper>()));

  moduleLocator.registerLazySingleton<MerchantRepository>(
      () => MerchantRepositoryImpl(remoteMerchantDataSource: moduleLocator<RemoteMerchantDataSource>()));

  moduleLocator.registerLazySingleton<MediaContentRepository>(
      () => MediaContentRepositoryImpl(mediaContentDataSource: moduleLocator<RemoteMediaContentDataSource>()));

  moduleLocator.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
      remoteProductService: RemoteProductServiceImpl(dio: dio),
      localProductService: ProductDaoImpl(database: moduleLocator<Database>()),
      networkHelper: moduleLocator<NetworkHelper>()));

  moduleLocator.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl(
      remoteProductService: moduleLocator<RemoteCategoryDataSource>(), networkHelper: moduleLocator<NetworkHelper>()));

  moduleLocator.registerLazySingleton<PaymentRepository>(() => PaymentRepositoryImpl(
      paymentService: moduleLocator<RemotePaymentService>(),
      paymentDao: moduleLocator<PaymentDao>(),
      networkHelper: moduleLocator<NetworkHelper>()));
}
