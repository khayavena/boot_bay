import 'package:bootbay/src/data/remote/mediacontent/remote_media_content_datasource.dart';
import 'package:bootbay/src/model/mediacontent/media_content_response.dart';
import 'package:bootbay/src/repository/mediacontent/media_content_repository.dart';
import 'package:flutter/material.dart';

class MediaContentRepositoryImpl implements MediaContentRepository {
  RemoteMediaContentDataSource _mediaContentDataSource;

  MediaContentRepositoryImpl({@required RemoteMediaContentDataSource mediaContentDataSource})
      : _mediaContentDataSource = mediaContentDataSource;

  Future<MediaContentResponse> uploadMerchantLogo(String path, String merchantId) async {
    return _mediaContentDataSource.uploadMerchantLogo(path, merchantId);
  }

  @override
  Future<MediaContentResponse> uploadCategory(String path, String merchantId) {
    return _mediaContentDataSource.uploadCategory(path, merchantId);
  }

  @override
  Future<MediaContentResponse> uploadProduct(String path, String id) {
    return _mediaContentDataSource.uploadCategory(path, id);
  }
}
