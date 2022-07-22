class TokenRequest {
  String merchantId;
  String customerId;
  bool isAfrica;

  TokenRequest.fromJson(Map<String, dynamic> json)
      : merchantId = json['merchantId'],
        customerId = json['customerId'],
        isAfrica = json['isAfrica'];

  Map<String, dynamic> toJson() => {
        'merchantId': merchantId,
        'customerId': customerId,
        'isAfrica': isAfrica,
      };

  TokenRequest({
    required this.merchantId,
    required this.customerId,
    required this.isAfrica,
  });
}
