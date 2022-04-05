import 'dart:convert';

import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/model/pay_method/yoco_pay_method.dart';
import 'package:bootbay/src/model/payment_request.dart';
import 'package:bootbay/src/model/token_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class YocoViewModel extends ChangeNotifier {
  static const String GATE_WAY = "yoco";
  static const String AMOUNT_DELIMER = ".";
  Loader _loader;
  YocoPayMethod _yocoPayMethod;
  final String yocoPubKey;
  String _finalUrl;
  String _errorMessage;

  PaymentRequest _request;

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

  void buildPay(TokenResponse token, double finalAmount, String currency,
      String itemIds, String merchantId, yokoToken) async {
    _request = PaymentRequest(
        chargeAmount: finalAmount,
        chargeAmountInCents:
            finalAmount.toStringAsFixed(2).toString().replaceAll(".", ""),
        orderId: token.orderId,
        nonce: yocoPayMethod.yocoToken.id,
        itemIds: itemIds,
        currency: currency,
        merchantId: merchantId,
        startTime: DateTime.now().toString(),
        deviceData: 'result.deviceData',
        gateWay: GATE_WAY);
  }

  PaymentRequest get finalRequest => _request;

  Future<String> buildUrl(double finalAmount, String currency) async {
    setState(Loader.busy);
    var dropInHtml = await rootBundle.loadString("assets/html/yocoDropIn.html");
    var inCents = finalAmount.toString().replaceAll(AMOUNT_DELIMER, "");
    dropInHtml = dropInHtml
        .replaceAll("payAmount", inCents)
        .replaceAll("currencySymbol", "'$currency'")
        .replaceAll("yocoPubKey", "'$yocoPubKey'");
    final String contentBase64 =
        base64Encode(const Utf8Encoder().convert(dropInHtml));
    _finalUrl = 'data:text/html;base64,$contentBase64';
    setState(Loader.complete);
    return _finalUrl;
  }
}
