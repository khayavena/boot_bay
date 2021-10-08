import 'package:bootbay/src/model/mediacontent/media_content_response.dart';

abstract class RemoteMediaContentDataSource {
  Future<MediaContentResponse> uploadMerchantLogo(String path, String merchantId);

  Future<MediaContentResponse> uploadCategory(String path, String merchantId);

  Future<MediaContentResponse> uploadProductImage(String path, String id);
}
