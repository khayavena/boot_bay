import '../../bin_data.dart';
import '../../details.dart';

class PaymentNonce {
  BinData binData;
  String description;
  Details details;
  String nonce;
  String type;
  bool vaulted;

  PaymentNonce(
      {required this.binData,
      required this.description,
      required this.details,
      required this.nonce,
      required this.type,
      required this.vaulted});

  factory PaymentNonce.fromJson(Map<String, dynamic> json) {
    return PaymentNonce(
      binData: BinData.fromJson(json['binData']),
      description: json['description'],
      details: Details.fromJson(json['details']),
      nonce: json['nonce'],
      type: json['type'],
      vaulted: json['vaulted'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['nonce'] = this.nonce;
    data['type'] = this.type;
    data['vaulted'] = this.vaulted;
    data['binData'] = this.binData.toJson();
    data['details'] = this.details.toJson();
    return data;
  }
}
