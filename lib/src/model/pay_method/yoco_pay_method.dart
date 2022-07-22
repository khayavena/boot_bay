import 'package:bootbay/src/model/pay_method/yoco_token.dart';

class YocoPayMethod {
  Result result;
  DateTime dateTime;

  YocoPayMethod({required this.result, required this.dateTime});

  factory YocoPayMethod.fromJson(Map<String, dynamic> json) {
    return YocoPayMethod(
      dateTime: json['dateTime'] ?? DateTime.now(),
      result: Result.fromJson(json['result']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['dateTime'] = this.dateTime;
      data['yocoToken'] = this.result.toJson();
    }
    return data;
  }
}
