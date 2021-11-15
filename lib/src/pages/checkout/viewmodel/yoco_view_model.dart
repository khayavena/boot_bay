import 'dart:convert';

import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/model/pay_method/yoco_pay_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class YocoViewModel extends ChangeNotifier {
  Loader _loader;
  YocoPayMethod _yocoPayMethod;
  final String yocoPubKey;
  String _finalUrl;
  String _errorMessage;

  YocoViewModel(this.yocoPubKey);

  void fromJson(Map<String, dynamic> json) {
    setState(Loader.busy);
    _yocoPayMethod = YocoPayMethod.fromJson(json);
    setState(Loader.complete);
    notifyListeners();
  }

  void setState(Loader loader) {
    _loader = loader;
    notifyListeners();
  }

  YocoPayMethod get yocoPayMethod => _yocoPayMethod;

  String get finalUrl => _finalUrl;

  Loader get loader => _loader;

  set errorMessage(s) {
    _errorMessage = s;
    setState(Loader.error);
    notifyListeners();
  }

  String get errorMessage => _errorMessage;

}
