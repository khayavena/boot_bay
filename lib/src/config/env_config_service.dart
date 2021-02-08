import 'EnvConfig.dart';

abstract class EnvConfigService {
  Future<EnvConfig> getEnvConfig();

  bool isProd();
}
