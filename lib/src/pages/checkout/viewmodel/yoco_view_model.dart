import 'dart:convert';

import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/model/pay_method/model/payment_request.dart';
import 'package:bootbay/src/model/pay_method/model/token_response.dart';
import 'package:bootbay/src/model/pay_method/yoco_pay_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class YocoViewModel extends ChangeNotifier {
  static const String GATE_WAY = "yoco";
  static const String AMOUNT_DELIMITER = ".";
  static const String htmlAssetPath = "assets/html/yocoDropIn.html";
  static const String htmlContentTye = "data:text/html;base64";
  static const String payKey = "payAmount";
  static const String currencySymbol = "currencySymbol";
  static const String yocoKey = "yocoPubKey";

  late Loader _loader = Loader.idl;
  late YocoPayMethod? _yocoPayMethod = null;
  final String yocoPubKey;
  late String _finalUrl = "";
  late String _errorMessage;

  late PaymentRequest _request;

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

  YocoPayMethod? get yocoPayMethod => _yocoPayMethod;

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
        orderId: token.orderId ?? '',
        nonce: yocoPayMethod?.result.id ?? '',
        itemIds: itemIds,
        currency: currency,
        merchantId: merchantId,
        startTime: DateTime.now().toString(),
        deviceData: 'result.deviceData',
        gateWay: GATE_WAY);
  }

  PaymentRequest get finalRequest => _request;

  Future<String> buildUrl(double finalAmount, String currency) async {
    final dropInHtml = await rootBundle.loadString(htmlAssetPath);
    final amountInCents =
        finalAmount.toStringAsFixed(2).replaceAll(AMOUNT_DELIMITER, "");
    final dropInHtmlView = dropInHtml
        .replaceAll(payKey, amountInCents)
        .replaceAll(currencySymbol, "'$currency'")
        .replaceAll(yocoKey, "'$yocoPubKey'");
    final String encodedContentBase64 =
        base64Encode(const Utf8Encoder().convert(dropInHtmlView));
    _finalUrl = dropInHtmlView;
    return _finalUrl;
  }
}
