import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/network_exception.dart';
import 'package:bootbay/src/model/mediacontent/media_content_response.dart';
import 'package:bootbay/src/repository/mediacontent/media_content_repository.dart';
import 'package:bootbay/src/viewmodel/ViewModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MediaContentViewModel extends ViewModel {
  MediaContentRepository _mediaContentRepository;
  Loader _loader;

  String dataErrorMessage;

  MediaContentResponse mediaResponse;

  MediaContentViewModel({@required MediaContentRepository mediaContentRepository})
      : _mediaContentRepository = mediaContentRepository;

  Future<MediaContentResponse> saveFile(String path, String id) async {
    _loader = Loader.busy;
    notifyListeners();
    try {
      mediaResponse = await _mediaContentRepository.uploadMerchantLogo(path, id);
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

  Future<MediaContentResponse> saveCategoryFile(String path, String id) async {
    _loader = Loader.busy;
    notifyListeners();
    try {
      mediaResponse = await _mediaContentRepository.uploadCategory(path, id);
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

  Future<MediaContentResponse> saveProductFile(String path, String id) async {
    _loader = Loader.busy;
    notifyListeners();
    try {
      mediaResponse = await _mediaContentRepository.uploadProduct(path, id);
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
