import 'package:flutter/material.dart';

class TokenRequest {
  String merchantId;
  String customerId;

  TokenRequest.fromJson(Map<String, dynamic> json)
      : merchantId = json['merchantId'],
        customerId = json['customerId'];

  Map<String, dynamic> toJson() => {
        'merchantId': merchantId,
        'customerId': customerId,
      };

  TokenRequest({
    @required this.merchantId,
    @required this.customerId,
  });
}
