import 'package:bootbay/src/config/EnvConfig.dart';
import 'package:bootbay/src/di/boot_bay_module_locator.dart';

String getImageUri(String id) {
  return moduleLocator<EnvConfig>().baseUrl + '/content/image/$id';
}
