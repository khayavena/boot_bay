import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/network_exception.dart';
import 'package:bootbay/src/model/mediacontent/media_content_response.dart';
import 'package:bootbay/src/pages/mediacontent/repository/mediacontent/media_content_repository.dart';
import 'package:bootbay/src/viewmodel/ViewModel.dart';
import 'package:dio/dio.dart';

class MediaViewModel extends ViewModel {
  MediaContentRepository _mediaContentRepository;
  late Loader _loader = Loader.idl;

  late String dataErrorMessage = '';

  MediaContentResponse mediaResponse = MediaContentResponse();

  MediaViewModel({required MediaContentRepository mediaContentRepository})
      : _mediaContentRepository = mediaContentRepository;

  Future<MediaContentResponse> saveImage(
      String path, String id, String type) async {
    print('saving product file');
    _loader = Loader.busy;
    notifyListeners();
    try {
      mediaResponse = await _mediaContentRepository.uploadImage(path, id, type);
      _loader = Loader.complete;
      notifyListeners();
      return mediaResponse;
    } on NetworkException catch (error) {
      dataErrorMessage = error.message;
      _loader = Loader.error;
      notifyListeners();
    } on DioError catch (error) {
      _loader = Loader.error;
      handleDioError(error);
    } catch (error) {
      _loader = Loader.error;
      notifyListeners();
    }
    return mediaResponse;
  }

  clear() {
    _loader = Loader.idl;
  }

  Loader get status => _loader;
}
