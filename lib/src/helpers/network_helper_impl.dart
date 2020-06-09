import 'dart:io';

import 'package:bootbay/src/helpers/network_helper.dart';

class NetworkHelperImpl implements NetworkHelper {
  @override
  Future<bool> isNotConnected() async {
    bool notConnected;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        notConnected = false;
      }
    } on SocketException catch (_) {
      notConnected = true;
    }
    return notConnected;
  }
}
