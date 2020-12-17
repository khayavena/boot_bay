import 'package:bootbay/src/model/merchant/merchant.dart';

class MerchantResponse {
  Merchant _merchant;
  String _configId;
  String _message;

  String get configId => _configId;

  String get message => _message;

  Merchant get merchant => _merchant;

  MerchantResponse({String configId, String message, Merchant merchant}) {
    _configId = configId;
    _message = message;
    _merchant = merchant;
  }

  MerchantResponse.fromJson(dynamic json) {
    _configId = json["configId"] ?? '';
    _message = json["message"];
    _merchant = Merchant.fromJson(json["merchant"]);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["configId"] = _configId;
    map["message"] = _message;
    map["merchant"] = _merchant.toJson();
    return map;
  }
}
