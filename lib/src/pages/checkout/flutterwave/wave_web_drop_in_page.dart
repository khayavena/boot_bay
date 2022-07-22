import 'dart:convert';

import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/pages/checkout/viewmodel/yoco_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WaveWebDropInPage extends StatefulWidget {
  static const String TOKEN_AUTHORIZATION = "token_authorization";
  final double finalAmount;
  final String itemIds;
  final String currency;
  final String merchantId;
  late String url;

  WaveWebDropInPage(
      {required this.finalAmount,
      required this.itemIds,
      required this.currency,
      required this.merchantId,
      required this.url});

  @override
  _WaveWebDropInPageState createState() => _WaveWebDropInPageState();
}

class _WaveWebDropInPageState extends State<WaveWebDropInPage> {
  late YocoViewModel yocoViewModel;

  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      yocoViewModel = Provider.of<YocoViewModel>(
        context,
        listen: false,
      );
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
    return Consumer<YocoViewModel>(
        builder: (BuildContext context, vm, Widget? child) {
      switch (vm.loader) {
        case Loader.error:
          final snackBar = SnackBar(
            content: Text(vm.errorMessage),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
      }
      return WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (string) async {},
        onWebViewCreated: (controller) {},
        javascriptChannels: Set.from([
          JavascriptChannel(
              name: "DropInChannel",
              onMessageReceived: (JavascriptMessage result) async {
                switch (result.message) {
                  case "started":
                    // vm.setState(Loader.busy);
                    break;
                  default:
                    var json = jsonDecode(result.message);
                    print(json);
                    String error = json['error'] ?? null;
                    if (error == null) {
                      vm.fromJson(json);
                      Navigator.pop(context);
                    } else {
                      vm.errorMessage = error;
                    }
                }
              }),
        ]),
      );
    });
  }
}

Future<String> buildUrl(
    double finalAmount, String currency, String yocoPubKey) async {
  var dropInHtml = await rootBundle.loadString("assets/html/yocoDropIn.html");
  var inCents = finalAmount.toString().replaceAll(".", "");
  dropInHtml = dropInHtml
      .replaceAll("payAmount", inCents)
      .replaceAll("currencySymbol", "'$currency'")
      .replaceAll("yocoPubKey", "'$yocoPubKey'");
  final String contentBase64 =
      base64Encode(const Utf8Encoder().convert(dropInHtml));
  var url = 'data:text/html;base64,$contentBase64';
  return url;
}
