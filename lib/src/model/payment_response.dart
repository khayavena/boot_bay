class PaymentResponse {
  late String id;
  late String auditId;
  late String message;
  late bool status;
  late double totalAmount;
  late String currency;

  PaymentResponse();

  PaymentResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        auditId = json['auditId'],
        message = json['message'],
        status = json['status'],
        totalAmount = json['totalAmount'],
        currency = json['currency'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'auditId': auditId,
        'message': message,
        'status': status,
        'totalAmount': totalAmount,
        'currency': currency,
      };
}
