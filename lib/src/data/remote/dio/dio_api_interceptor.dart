import 'dart:io';

import 'package:dio/dio.dart';

class DioApiInterceptor extends Interceptor {
  static final String _apiKey = "Subscription-Key";

  final String _appKey;

  DioApiInterceptor({String appKey = ""}) : _appKey = appKey;

  @override
  onRequest(RequestOptions options, inte) {
    options.headers[_apiKey] = _appKey;
    options.headers[HttpHeaders.contentTypeHeader] = ContentType.json.value;
    options.responseType = ResponseType.json;
    return super.onRequest(options, inte);
  }

  @override
  void onResponse(Response response, inte) {
    super.onResponse(response, inte);
  }
}
