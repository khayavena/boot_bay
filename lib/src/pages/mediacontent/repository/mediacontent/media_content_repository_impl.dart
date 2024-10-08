import 'package:bootbay/src/data/remote/mediacontent/remote_media_content_datasource.dart';
import 'package:bootbay/src/model/mediacontent/media_content_response.dart';

import 'media_content_repository.dart';

class MediaContentRepositoryImpl implements MediaContentRepository {
  RemoteMediaContentDataSource _mediaContentDataSource;

  MediaContentRepositoryImpl(
      {required RemoteMediaContentDataSource mediaContentDataSource})
      : _mediaContentDataSource = mediaContentDataSource;

  @override
  Future<MediaContentResponse> uploadImage(
      String path, String id, String type) {
    return _mediaContentDataSource.uploadImage(path, id, type);
  }
}
