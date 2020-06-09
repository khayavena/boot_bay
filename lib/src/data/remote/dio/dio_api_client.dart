import 'package:dio/dio.dart';
import 'package:bootbay/src/data/remote/dio/dio_api_interceptor.dart';

class DioClient {
  static Dio getClient(String baseUrl, String subscriptionKey) {
    return Dio()
      ..options = BaseOptions(
        baseUrl: baseUrl,
      )
      ..interceptors.add(DioApiInterceptor(appKey: subscriptionKey))
      ..interceptors.add(LogInterceptor(
          request: true,
          requestHeader: true,
          responseHeader: true,
          responseBody: true,
          requestBody: true));
  }
}
