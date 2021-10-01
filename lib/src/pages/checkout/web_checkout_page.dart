import 'dart:convert';

import 'package:bootbay/res.dart';
import 'package:bootbay/src/model/payment_nonce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebCheckoutPage extends StatefulWidget {
  static const String TOKEN_AUTHORIZATION = "token_authorization";
  final String authToken;
  final OnWebPaymentNonceListener onWebPaymentNonceListener;

  WebCheckoutPage({@required this.onWebPaymentNonceListener, this.authToken});

  @override
  _WebCheckoutPageState createState() => _WebCheckoutPageState();
}

class _WebCheckoutPageState extends State<WebCheckoutPage> {
  WebViewController _controller;

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
                  var nonce = await _controller.evaluateJavascript(onReceiveMethod);
                  Map json = jsonDecode(nonce);
                  PaymentNonce paymentNonce = PaymentNonce.fromJson(json);
                  widget.onWebPaymentNonceListener.onWebPaymentNonce(paymentNonce: paymentNonce.nonce, deviceData: '');
                  break;
                case 'failed':
                  widget.onWebPaymentNonceListener.onWebNonceState(NonceState.failed);
                  break;
                case 'canceled':
                  widget.onWebPaymentNonceListener.onWebNonceState(NonceState.canceled);
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
    dropInHtml = dropInHtml.replaceAll(WebCheckoutPage.TOKEN_AUTHORIZATION, widget.authToken);
    final String contentBase64 = base64Encode(const Utf8Encoder().convert(dropInHtml));
    return contentBase64;
  }
}

abstract class OnWebPaymentNonceListener {
  void onWebPaymentNonce({final String paymentNonce, final String deviceData});

  void onWebNonceState(NonceState nonceState);
}

enum NonceState { failed, canceled }
