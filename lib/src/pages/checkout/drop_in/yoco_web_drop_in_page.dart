import 'dart:convert';

import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/pages/checkout/viewmodel/yoco_view_model.dart';
import 'package:bootbay/src/wigets/shared/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../helpers/ResFont.dart';
import '../../../wigets/shared/loading/color_loader_4.dart';

class YocoWebDropInPage extends StatefulWidget {
  final double finalAmount;
  final String itemIds;
  final String currency;
  final String merchantId;
  final String url;

  const YocoWebDropInPage(
      {required this.finalAmount,
      required this.itemIds,
      required this.currency,
      required this.merchantId,
      required this.url});

  @override
  _YocoWebDropInPageState createState() => _YocoWebDropInPageState();
}

class _YocoWebDropInPageState extends State<YocoWebDropInPage> {
  static const DropInChannel = "DropInChannel";
  static const DropInStarted = "started";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build("DR/CR Card Payment", context),
      body: loadDropIn(),
    );
  }

  Widget loadDropIn() {
    return Consumer<YocoViewModel>(
        builder: (BuildContext context, yocoViewModel, Widget? child) {
      switch (yocoViewModel.loader) {
        case Loader.error:
          break;
        case Loader.busy:
          // TODO: Handle this case.
          break;
        case Loader.complete:
          // TODO: Handle this case.
          break;
        case Loader.idl:
          // TODO: Handle this case.
          break;
      }
      return Stack(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                      child: Text(
                    widget.currency +
                        "-" +
                        widget.finalAmount.toStringAsFixed(2).toString(),
                    style: TextStyle(
                      color: Color(0xff2783a9),
                      fontSize: 25,
                      fontWeight: mediumFont,
                      fontStyle: FontStyle.normal,
                      letterSpacing: -0.6400000000000001,
                    ),
                  )),
                  SizedBox(height: 16),
                  Expanded(
                    child: WebView(
                      // initialUrl: widget.url,
                      javascriptMode: JavascriptMode.unrestricted,
                      onPageFinished: (string) async {},
                      onWebViewCreated: (controller) {
                        controller.loadHtmlString(widget.url);
                      },
                      javascriptChannels: Set.from([
                        JavascriptChannel(
                            name: DropInChannel,
                            onMessageReceived:
                                (JavascriptMessage result) async {
                              switch (result.message) {
                                case DropInStarted:
                                  yocoViewModel.setState(Loader.busy);
                                  break;
                                default:
                                  var json = jsonDecode(result.message);

                                  String? error = json['error'] ?? null;
                                  if (error == null) {
                                    yocoViewModel.fromJson(json);
                                    Navigator.pop(context);
                                  } else {
                                    yocoViewModel.errorMessage = error;
                                    yocoViewModel.setState(Loader.error);
                                  }
                              }
                            }),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          yocoViewModel.loader == Loader.busy
              ? WidgetLoader()
              : SizedBox(height: 0)
        ],
      );
    });
  }
}
