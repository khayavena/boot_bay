import 'dart:io';

import 'package:bootbay/src/data/remote/mediacontent/remote_media_content_datasource.dart';
import 'package:bootbay/src/model/mediacontent/media_content_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RemoteMediaContentDataSourceImpl implements RemoteMediaContentDataSource {
  Dio _dio;
  static String _contentType = 'application/x-www-form-urlencoded';
  static String baseEndPoint = '/media';

  RemoteMediaContentDataSourceImpl({@required Dio dio}) {
    _dio = dio;
    _dio.options.headers
        .update(HttpHeaders.contentTypeHeader, (value) => _contentType);
  }

  Future<MediaContentResponse> uploadMerchantLogo(
      String path, String merchantId) async {
    var formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(path),
    });
    var response = await _dio.post('$baseEndPoint/merchant/$merchantId/logo',
        data: formData);
    return MediaContentResponse.fromJson(response.data);
  }

  Future<MediaContentResponse> uploadCategory(
      String path, String categoryId) async {
    var formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(path),
    });
    var response =
        await _dio.post('$baseEndPoint/category/$categoryId/icon', data: formData);
    return MediaContentResponse.fromJson(response.data);
  }
}
