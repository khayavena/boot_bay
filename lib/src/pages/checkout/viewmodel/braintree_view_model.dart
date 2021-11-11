import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/model/payment_request.dart';
import 'package:bootbay/src/model/token_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_braintree/flutter_braintree.dart';

class BrainTreeViewModel extends ChangeNotifier {
  PaymentRequest _request;

  Loader _state = Loader.idl;

  void authorizePay(TokenResponse token, double finalAmount, String currency,
      String itemIds, String merchantId) async {
    setState(Loader.busy);
    final request = _buildRequest(token.token, finalAmount, currency);
    var result = await BraintreeDropIn.start(request);
    if (result != null) {
      _request = PaymentRequest(
          chargeAmount: finalAmount,
          orderId: token.orderId,
          nonce: result.paymentMethodNonce.nonce,
          itemIds: itemIds,
          merchantId: merchantId,
          startTime: DateTime.now().toString(),
          deviceData: result.deviceData);
      setState(Loader.complete);
    } else {
      setState(Loader.error);
    }
  }

  BraintreeDropInRequest _buildRequest(
      String token, double finalAmount, String currency) {
    return BraintreeDropInRequest(
      maskCardNumber: true,
      clientToken: token,
      collectDeviceData: true,
      googlePaymentRequest: BraintreeGooglePaymentRequest(
        totalPrice: finalAmount.toStringAsFixed(2),
        currencyCode: currency,
        billingAddressRequired: false,
      ),
      paypalRequest: BraintreePayPalRequest(
        amount: finalAmount.toString(),
        displayName: 'Boot Bay',
      ),
    );
  }

  PaymentRequest get finalRequest => _request;

  Loader get state => _state;

  void setState(Loader state) {
    _state = state;
    notifyListeners();
  }
}
