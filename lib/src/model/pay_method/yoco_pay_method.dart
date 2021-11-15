import 'package:bootbay/src/model/pay_method/yoco_token.dart';

class YocoPayMethod {
  YocoToken yocoToken;
  DateTime dateTime;

  YocoPayMethod({this.yocoToken, this.dateTime});

  factory YocoPayMethod.fromJson(Map<String, dynamic> json) {
    return YocoPayMethod(
      dateTime: json['dateTime'] ?? DateTime.now(),
      yocoToken:
           YocoToken.fromJson(json['result'])
         ,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.yocoToken != null) {
      data['dateTime'] = this.dateTime;
      data['yocoToken'] = this.yocoToken.toJson();
    }
    return data;
  }
}
