import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {

  String dataErrorMessage;

  void handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        dataErrorMessage = 'Connection timeout try again';
        break;
      case DioErrorType.SEND_TIMEOUT:
        dataErrorMessage = 'Could not send request';
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        dataErrorMessage = 'Could not recieve data';
        break;
      case DioErrorType.RESPONSE:
        switch (error.response.statusCode) {
          case 500:
            dataErrorMessage = 'Internal Server Error';
            break;
          case 404:
            dataErrorMessage = 'Results Not Found';
            break;
          case 401:
            dataErrorMessage = 'Unauthorised  to access';
            break;
        }
        break;
      case DioErrorType.CANCEL:
        dataErrorMessage = 'Canceled Request';
        break;
      case DioErrorType.DEFAULT:
        dataErrorMessage = 'Somethong went wrong';
        break;
    }
    notifyListeners();
  }
}
