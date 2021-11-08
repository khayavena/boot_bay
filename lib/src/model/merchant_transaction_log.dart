class MerchantTransactionLog {
  String id;
  String merchantId;
  double amount;
  String token;
  String nonce;
  String startTime;
  String endTime;
  String merchantConfigId;
  String status;
  String deviceData;
  String itemIds;
  String transactionId;

  MerchantTransactionLog(
      {this.id,
      this.merchantId,
      this.amount,
      this.token,
      this.nonce,
      this.startTime,
      this.endTime,
      this.merchantConfigId,
      this.status,
      this.deviceData,
      this.itemIds,
      this.transactionId});

  MerchantTransactionLog.fromJson(json)
      : id = json['id'],
        merchantId = json['merchantId'],
        amount = json['amount'],
        token = json['token'],
        nonce = json['nonce'],
        startTime = json['startTime'],
        endTime = json['endTime'],
        merchantConfigId = json['merchantConfigId'],
        itemIds = json['itemIds'],
        deviceData = json['deviceData'],
        transactionId = json['transactionId'],
        status = json['status'];

  Map<String, dynamic> toJson() => {
        'id': id,
        "merchantId": merchantId,
        'token': token,
        "amount": amount,
        "nonce": nonce,
        "startTime": startTime,
        "endTime": endTime,
        "merchantConfigId": merchantConfigId,
        "itemIds": itemIds,
        "deviceData": deviceData,
        "transactionId": transactionId,
        "status": status
      };
}
