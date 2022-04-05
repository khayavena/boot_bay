import 'dart:convert';

import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/pages/checkout/viewmodel/yoco_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../helpers/ResColor.dart';
import '../../../wigets/shared/loading/color_loader_4.dart';

class YocoWebDropInPage extends StatefulWidget {
  final double finalAmount;
  final String itemIds;
  final String currency;
  final String merchantId;

  const YocoWebDropInPage({
    this.finalAmount,
    this.itemIds,
    this.currency,
    this.merchantId,
  });

  @override
  _YocoWebDropInPageState createState() => _YocoWebDropInPageState();
}

class _YocoWebDropInPageState extends State<YocoWebDropInPage> {
  static const DropInChannel = "DropInChannel";
  static const DropInStarted = "started";
  YocoViewModel yocoViewModel;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      yocoViewModel = Provider.of<YocoViewModel>(
        context,
        listen: false,
      );
      yocoViewModel.buildUrl(widget.finalAmount, widget.currency);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryWhite,
        bottomOpacity: 0.0,
        elevation: 0.0,
        automaticallyImplyLeading: true,
        title: Text(
          "Authorise Credit Card",
          style: TextStyle(color: secondaryBlueColor),
        ),
      ),
      body: loadDropIn(),
    );
  }

  Widget loadDropIn() {
    return Consumer<YocoViewModel>(
        builder: (BuildContext context, vm, Widget child) {
      switch (vm.loader) {
        case Loader.error:
          break;
      }
      return Stack(
        children: [
          Container(
            child: vm.finalUrl == null
                ? WidgetLoader()
                : WebView(
                    initialUrl: vm.finalUrl,
                    javascriptMode: JavascriptMode.unrestricted,
                    onPageFinished: (string) async {},
                    onWebViewCreated: (controller) {},
                    javascriptChannels: Set.from([
                      JavascriptChannel(
                          name: DropInChannel,
                          onMessageReceived: (JavascriptMessage result) async {
                            switch (result.message) {
                              case DropInStarted:
                                vm.setState(Loader.busy);
                                break;
                              default:
                                var json = jsonDecode(result.message);
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
                  ),
          ),
          vm.loader == Loader.busy ? WidgetLoader() : SizedBox(height: 0)
        ],
      );
    });
  }
}
