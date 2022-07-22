import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  late String dataErrorMessage;

  void handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        dataErrorMessage = 'Connection timeout try again';
        break;
      case DioErrorType.sendTimeout:
        dataErrorMessage = 'Timeout could not send request';
        break;
      case DioErrorType.receiveTimeout:
        dataErrorMessage = 'Timeout could not receive data';
        break;
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case 500:
            dataErrorMessage = 'Internal Server Error';
            break;
          case 404:
            dataErrorMessage = 'Results Not Found';
            break;
          case 401:
            dataErrorMessage = 'Unauthorised to access';
            break;
        }
        break;
      case DioErrorType.cancel:
        dataErrorMessage = 'Canceled Request';
        break;
      case DioErrorType.other:
        dataErrorMessage = 'Something went wrong';
        break;
    }
    notifyListeners();
  }
}
