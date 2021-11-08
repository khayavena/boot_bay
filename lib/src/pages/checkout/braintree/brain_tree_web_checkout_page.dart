import 'dart:convert';

import 'package:bootbay/res.dart';
import 'package:bootbay/src/model/payment_nonce.dart';
import 'package:bootbay/src/model/payment_request.dart';
import 'package:bootbay/src/model/token_request.dart';
import 'package:bootbay/src/model/token_response.dart';
import 'package:bootbay/src/pages/checkout/viewmodel/payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebCheckoutPage extends StatefulWidget {
  static const String TOKEN_AUTHORIZATION = "token_authorization";
  final String authToken;
  final double finalAmount;
  final String itemIds;
  final String currency;
  final String merchantId;

  WebCheckoutPage(
      {this.authToken,
      this.finalAmount,
      this.itemIds,
      this.currency,
      this.merchantId});

  @override
  _WebCheckoutPageState createState() => _WebCheckoutPageState();
}

class _WebCheckoutPageState extends State<WebCheckoutPage> {
  WebViewController _controller;
  PaymentViewModel _paymentViewModel;
  TokenResponse _tokenResponse;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _paymentViewModel = Provider.of<PaymentViewModel>(
        context,
        listen: false,
      );
      _paymentViewModel.getToken(
          TokenRequest(merchantId: widget.merchantId, customerId: '614999179',isAfrica: false));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Web View"),
      ),
      body: loadDropIn(),
    );
  }

  Widget loadDropIn() {
    var webViewMethod = "Print";
    var onReceiveMethod = 'onPaymentMethodReceived()';
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      onPageFinished: (string) {},
      javascriptChannels: Set.from([
        JavascriptChannel(
            name: webViewMethod,
            onMessageReceived: (JavascriptMessage result) async {
              switch (result.message) {
                case 'success':
                  var nonce =
                      await _controller.evaluateJavascript(onReceiveMethod);
                  Map json = jsonDecode(nonce);
                  PaymentNonce paymentNonce = PaymentNonce.fromJson(json);
                  initiatePayment(
                      _tokenResponse.orderId,
                      paymentNonce.nonce,
                      widget.finalAmount,
                      _tokenResponse.startTime,
                      widget.merchantId,
                      widget.itemIds,
                      '');

                  break;
                case 'failed':
                  break;
                case 'canceled':
                  break;
              }
            }),
      ]),
      onWebViewCreated: (webViewController) async {
        _controller = webViewController;
        var contentBase64 = await _loadDropInHtmlFromAssets();
        _controller.loadUrl('data:text/html;base64,$contentBase64');
      },
    );
  }

  Future<String> _loadDropInHtmlFromAssets() async {
    String dropInHtml = await rootBundle.loadString(Res.brainTreeDropIn);
    dropInHtml = dropInHtml.replaceAll(
        WebCheckoutPage.TOKEN_AUTHORIZATION, widget.authToken);
    final String contentBase64 =
        base64Encode(const Utf8Encoder().convert(dropInHtml));
    return contentBase64;
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
}
