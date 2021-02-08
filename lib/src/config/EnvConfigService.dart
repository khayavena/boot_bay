import 'dart:convert';

import 'package:bootbay/res.dart';
import 'package:bootbay/src/config/EnvConfig.dart';
import 'package:bootbay/src/config/env_config_service.dart';
import 'package:flutter/services.dart';

class EnvConfigServiceImpl implements EnvConfigService {
  static final errorMessage = 'Error loading config.';
  Flavor flavor;
  EnvConfig envConfig;

  EnvConfigServiceImpl(this.flavor);

  @override
  Future<EnvConfig> getEnvConfig() async {
    Map<String, dynamic> mapConfig = await _getConfig();
    dynamic val = mapConfig[this.flavor.toString()];
    envConfig = EnvConfig.fromJson(val);
    return envConfig;
  }

  Future _getConfig() async {
    return rootBundle
        .loadString(Res.env_config_file)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

  bool isProd() => this.flavor == Flavor.PROD;
}
