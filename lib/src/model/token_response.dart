class TokenResponse {
  String token;
  String message;
  String orderId;
  String startTime;
  String customerId;

  TokenResponse.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        message = json['message'],
        orderId = json['orderId'],
        customerId = json['customerId'],
        startTime = json['startTime'];

  Map<String, dynamic> toJson() => {
        'token': token,
        'message': message,
        'orderId': orderId,
        'customerId': customerId,
        'startTime': startTime,
      };
}
