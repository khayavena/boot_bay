import 'package:bootbay/src/model/mediacontent/media_content_response.dart';

abstract class MediaContentRepository {
  Future<MediaContentResponse> uploadMerchantLogo(String path, String merchantId);

  Future<MediaContentResponse> uploadCategory(String path, String merchantId);

  Future<MediaContentResponse> uploadProduct(String path, String id);
}
