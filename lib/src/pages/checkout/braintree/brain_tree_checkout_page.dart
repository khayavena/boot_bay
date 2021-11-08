import 'package:bootbay/res.dart';
import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/model/payment_request.dart';
import 'package:bootbay/src/model/token_request.dart';
import 'package:bootbay/src/model/token_response.dart';
import 'package:bootbay/src/pages/checkout/viewmodel/payment_view_model.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_4.dart';
import 'package:bootbay/src/wigets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:provider/provider.dart';

class BraintreeCheckoutCartPage extends StatefulWidget {
  final double finalAmount;
  final String itemIds;
  final String currency;
  final String merchantId;

  @override
  _BraintreeCheckoutCartPageState createState() =>
      _BraintreeCheckoutCartPageState();

  BraintreeCheckoutCartPage(
      {@required this.finalAmount,
      @required this.itemIds,
      @required this.currency,
      @required this.merchantId});
}

class _BraintreeCheckoutCartPageState extends State<BraintreeCheckoutCartPage> {
  PaymentViewModel _paymentViewModel;
  TokenResponse _tokenResponse;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _paymentViewModel = Provider.of<PaymentViewModel>(
        context,
        listen: false,
      );
      _paymentViewModel.getToken(TokenRequest(
          merchantId: widget.merchantId,
          customerId: '614999179',
          isAfrica: false));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Consumer<PaymentViewModel>(
          builder: (BuildContext context, paymentViewModel, Widget child) {
        switch (paymentViewModel.loader) {
          case Loader.busy:
            return WidgetLoader();
          case Loader.complete:
          case Loader.idl:
            if (paymentViewModel.paymentStatus == PaymentStatus.auth) {
              _tokenResponse = paymentViewModel.getTokenResponse;
              loadPaymentMethod(paymentViewModel.getTokenResponse);
            } else {
              bool value = paymentViewModel.getPaymentResponse.status;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                      child: paymentStatus(
                          paymentViewModel.getPaymentResponse.message,
                          isSuccess: value)),
                  Container(
                      width: 100, height: 100, child: Image.asset(Res.success)),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: TitleText(
                      text: paymentViewModel.getPaymentResponse.currency +
                          "-" +
                          paymentViewModel.getPaymentResponse.totalAmount
                              .toStringAsFixed(2)
                              .toString(),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Center(
                      child: TitleText(
                    text:
                        "Payment Id: " + paymentViewModel.getPaymentResponse.id,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ))
                ],
              );
            }
            break;
          case Loader.error:
            switch (paymentViewModel.paymentStatus) {
              case PaymentStatus.auth:
                return Container(
                  child: Center(child: paymentStatus('Auth failed')),
                );
              default:
                return Container(
                  child: Center(child: paymentStatus('Payment failed')),
                );
            }
        }
        return paymentStatus('Please wait, loading');
      })),
    );
  }

  Widget paymentStatus(String status, {bool isSuccess}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 80,
        ),
        Center(
          child: TitleText(
            text: status,
            fontSize: 22,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        isSuccess == null ? WidgetLoader() : SizedBox()
      ],
    );
  }

  void loadPaymentMethod(TokenResponse tokenResponse) async {
    final request = buildRequest(tokenResponse.token);
    BraintreeDropInResult result = await BraintreeDropIn.start(request);
    if (result != null) {
      initiatePayment(
          tokenResponse.orderId,
          result.paymentMethodNonce.nonce,
          widget.finalAmount,
          tokenResponse.startTime,
          widget.merchantId,
          widget.itemIds,
          result.deviceData);
    }
  }

  void initiatePayment(String orderId, String paymentNonce, double amount,
      String startTime, String merchantId, String itemIds, String deviceData) {
    PaymentRequest request = PaymentRequest(
        chargeAmount: amount,
        orderId: orderId,
        nonce: paymentNonce,
        itemIds: itemIds,
        merchantId: merchantId,
        startTime: startTime,
        deviceData: deviceData);
    _paymentViewModel.pay(request);
  }

  BraintreeDropInRequest buildRequest(String token) {
    return BraintreeDropInRequest(
      clientToken: token,
      collectDeviceData: true,
      googlePaymentRequest: BraintreeGooglePaymentRequest(
        totalPrice: widget.finalAmount.toStringAsFixed(2),
        currencyCode: widget.currency,
        billingAddressRequired: false,
      ),
      paypalRequest: BraintreePayPalRequest(
        amount: widget.finalAmount.toString(),
        displayName: 'Digi Titan',
      ),
    );
  }
}
