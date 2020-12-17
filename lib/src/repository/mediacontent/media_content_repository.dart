import 'package:bootbay/src/model/mediacontent/media_content_response.dart';

abstract class MediaContentRepository {
  Future<MediaContentResponse> uploadMerchantLogo(String path, String merchantId);
}
