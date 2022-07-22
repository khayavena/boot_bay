import 'package:bootbay/src/model/pay_method/yoco_source.dart';

class Result {
  String id;
  Source source;
  String sourceType;
  String status;

  Result(
      {required this.id,
      required this.source,
      required this.sourceType,
      required this.status});

  Result.fromJson(json)
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
