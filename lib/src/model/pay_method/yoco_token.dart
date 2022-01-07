import 'package:bootbay/src/model/pay_method/yoco_source.dart';

class YocoToken {
  String id;
  Source source;
  String sourceType;
  String status;

  YocoToken({this.id, this.source, this.sourceType, this.status});

  YocoToken.fromJson( json)
      : id = json['id'] ?? '',
        source = Source.fromJson(json['source']),
        sourceType = json['sourceType'],
        status = json['status'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sourceType'] = this.sourceType;
    data['status'] = this.status;
    if (this.source != null) {
      data['source'] = this.source.toJson();
    }
    return data;
  }
}
