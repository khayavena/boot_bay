import 'package:bootbay/src/config/EnvConfig.dart';
import 'package:bootbay/src/config/EnvConfigService.dart';
import 'package:bootbay/src/config/env_config_service.dart';
import 'package:bootbay/src/data/local/database/database.dart';
import 'package:bootbay/src/data/local/user/user_dao.dart';
import 'package:bootbay/src/data/local/user/user_dao_impl.dart';
import 'package:bootbay/src/data/remote/auth/remote_user_service.dart';
import 'package:bootbay/src/data/remote/auth/remote_user_service_Impl.dart';
import 'package:bootbay/src/data/remote/dio/dio_api_client.dart';
import 'package:bootbay/src/helpers/network_helper.dart';
import 'package:bootbay/src/helpers/network_helper_impl.dart';
import 'package:bootbay/src/repository/user/user_repository.dart';
import 'package:bootbay/src/repository/user/user_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';

class BootBayModule {
  final GetIt locator;
  final Flavor flavor;

  BootBayModule({@required this.locator, @required this.flavor});

  Future<void> setupLocator() async {
    final Database database = await AppDatabaseImpl.instance.database;
    var config = await locator<EnvConfigService>().getEnvConfig();
    locator.registerLazySingleton<Dio>(() => DioClient.getClient(
          config.baseUrl,
          config.appKey,
        ));
    locator.registerFactoryAsync(() => null);
    locator.registerLazySingleton<EnvConfigService>(
        () => EnvConfigServiceImpl(flavor));
    locator.registerLazySingleton<Database>(() => database);
    locator.registerLazySingleton<NetworkHelper>(() => NetworkHelperImpl());
    locator.registerLazySingleton<UserDao>(
        () => UserDaoImpl(database: locator<Database>()));
    locator.registerLazySingleton<RemoteUserService>(
        () => RemoteUserServiceImpl(dio: locator<Dio>()));
    locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
        userService: locator<RemoteUserService>(),
        userDao: locator<UserDao>(),
        networkHelper: locator<NetworkHelper>(),
      ),
    );
  }
}
