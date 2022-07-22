class PaymentRequest {
  double chargeAmount;
  String chargeAmountInCents;
  String nonce;
  String orderId;
  String merchantId;
  String itemIds;
  String deviceData;
  String startTime;
  String currency;
  String gateWay;

  PaymentRequest({
    required this.chargeAmount,
    required this.chargeAmountInCents,
    required this.nonce,
    required this.orderId,
    required this.merchantId,
    required this.itemIds,
    required this.deviceData,
    required this.startTime,
    required this.currency,
    required this.gateWay,
  });

  PaymentRequest.fromJson(Map<String, dynamic> json)
      : chargeAmount = json['chargeAmount'],
        chargeAmountInCents = json['chargeAmountInCents'],
        nonce = json['nonce'],
        orderId = json['orderId'],
        merchantId = json['merchantId'],
        itemIds = json['itemIds'],
        deviceData = json['deviceData'],
        startTime = json['startTime'],
        currency = json['currency'],
        gateWay = json['gateWay'];

  Map<String, dynamic> toJson() => {
        'chargeAmount': chargeAmount,
        'chargeAmountInCents': chargeAmountInCents,
        'nonce': nonce,
        'orderId': orderId,
        'merchantId': merchantId,
        'itemIds': itemIds,
        'deviceData': deviceData,
        'startTime': startTime,
        'currency': currency,
        'gateWay': gateWay,
      };
}
