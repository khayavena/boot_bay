import 'dart:io';

import 'package:bootbay/src/data/remote/mediacontent/remote_media_content_datasource.dart';
import 'package:bootbay/src/model/mediacontent/media_content_response.dart';
import 'package:dio/dio.dart';

class RemoteMediaContentDataSourceImpl implements RemoteMediaContentDataSource {
  late Dio _dio;
  static String _contentType = 'application/x-www-form-urlencoded';
  static String baseEndPoint = '/content/';

  RemoteMediaContentDataSourceImpl({required Dio dio}) {
    _dio = dio;
    _dio.options.headers
        .update(HttpHeaders.contentTypeHeader, (value) => _contentType);
  }

  @override
  Future<MediaContentResponse> uploadImage(
      String path, String id, String type) async {
    var formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(path),
    });
    final response =
        await _dio.post('$baseEndPoint$id/type/$type/upload', data: formData);
    return MediaContentResponse.fromJson(response.data);
  }
}
