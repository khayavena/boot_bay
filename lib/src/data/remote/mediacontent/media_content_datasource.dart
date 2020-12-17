import 'package:bootbay/src/model/mediacontent/media_content_response.dart';

abstract class MediaContentDataSource {
  Future<MediaContentResponse> uploadMerchantLogo(String path, String merchantId);
}
