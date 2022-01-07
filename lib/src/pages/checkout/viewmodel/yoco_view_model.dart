import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/model/pay_method/yoco_pay_method.dart';
import 'package:bootbay/src/model/payment_request.dart';
import 'package:bootbay/src/model/token_response.dart';
import 'package:flutter/cupertino.dart';

class YocoViewModel extends ChangeNotifier {
  static const String GATE_WAY = "yoco";
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
}
