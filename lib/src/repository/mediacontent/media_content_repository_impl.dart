import 'package:bootbay/src/data/remote/mediacontent/media_content_datasource.dart';
import 'package:bootbay/src/model/mediacontent/media_content_response.dart';
import 'package:bootbay/src/repository/mediacontent/media_content_repository.dart';
import 'package:flutter/material.dart';

class MediaContentRepositoryImpl implements MediaContentRepository {
  MediaContentDataSource _mediaContentDataSource;

  MediaContentRepositoryImpl({@required MediaContentDataSource mediaContentDataSource})
      : _mediaContentDataSource = mediaContentDataSource;

  Future<MediaContentResponse> uploadMerchantLogo(String path, String merchantId) async {
    return _mediaContentDataSource.uploadMerchantLogo(path, merchantId);
  }
}
