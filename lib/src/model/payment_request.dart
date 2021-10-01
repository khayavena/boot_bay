import 'package:flutter/material.dart';

class PaymentRequest {
  double chargeAmount;
  String nonce;
  String orderId;
  String merchantId;
  String itemIds;
  String deviceData;
  String startTime;

  PaymentRequest({
    @required this.chargeAmount,
    @required this.nonce,
    @required this.orderId,
    @required this.merchantId,
    @required this.itemIds,
    @required this.deviceData,
    @required this.startTime,
  });

  PaymentRequest.fromJson(Map<String, dynamic> json)
      : chargeAmount = json['chargeAmount'],
        nonce = json['nonce'],
        orderId = json['orderId'],
        merchantId = json['merchantId'],
        itemIds = json['itemIds'],
        deviceData = json['deviceData'],
        startTime = json['startTime'];

  Map<String, dynamic> toJson() => {
        'chargeAmount': chargeAmount,
        'nonce': nonce,
        'orderId': orderId,
        'merchantId': merchantId,
        'itemIds': itemIds,
        'deviceData': deviceData,
        'startTime': startTime,
      };
}
