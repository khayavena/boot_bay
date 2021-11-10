import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/model/product.dart';
import 'package:bootbay/src/model/token_request.dart';
import 'package:bootbay/src/model/token_response.dart';
import 'package:bootbay/src/model/user_profile.dart';
import 'package:bootbay/src/pages/checkout/viewmodel/flutterwave_view_model.dart';
import 'package:bootbay/src/pages/checkout/viewmodel/payment_view_model.dart';
import 'package:bootbay/src/pages/checkout/widget/bill_product_row_widget.dart';
import 'package:bootbay/src/wigets/currency_input_field.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_4.dart';
import 'package:bootbay/src/wigets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class FlutterCheckoutPage extends StatefulWidget {
  final double finalAmount;
  final String itemIds;
  final String currency;
  final String merchantId;
  final UserProfile currentUser;
  final List<Product> products;

  @override
  _FlutterCheckoutPageState createState() => _FlutterCheckoutPageState();

  FlutterCheckoutPage(
      {@required this.finalAmount,
      @required this.itemIds,
      @required this.currency,
      @required this.merchantId,
      @required this.currentUser,
      @required this.products});
}

class _FlutterCheckoutPageState extends State<FlutterCheckoutPage> {
  PaymentViewModel _paymentViewModel;
  FlutterWaveViewModel _waveViewModel;
  TokenResponse _tokenResponse;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _paymentViewModel = Provider.of<PaymentViewModel>(
        context,
        listen: false,
      );
      _paymentViewModel?.products = widget.products;
      _waveViewModel = Provider.of<FlutterWaveViewModel>(
        context,
        listen: false,
      );

      _paymentViewModel.getToken(TokenRequest(
          merchantId: widget.merchantId,
          customerId: widget.currentUser.id,
          isAfrica: true));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Consumer2<PaymentViewModel, FlutterWaveViewModel>(
          builder: (BuildContext context, payViewModel, waveViewModel,
              Widget child) {
        return _buildView(context, payViewModel, waveViewModel);
      })),
    );
  }

  Widget _buildBillWidget(
      BuildContext context, PaymentViewModel payViewModel, String status,
      {bool isSuccess}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 80,
        ),
        Center(
          child: TitleText(
            text: "Your Bill",
            fontSize: 22,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        CurrencyInputField(
          initVue: widget.finalAmount,
          onChanged: _onAmountChange,
          symbol: "R-",
        ),
        Center(
          child: TitleText(
            text: status,
            fontSize: 22,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
            child: ListView(
          padding: EdgeInsets.all(0),
          children: payViewModel.products
              .map((e) => BillProductRow(
                    expense: e,
                    currency: widget.currency,
                    onDismissed: onDismissed,
                    onUpdated: onUpdate,
                  ))
              .toList(),
        )),
        ElevatedButton(
            onPressed: () {
              beginPayment(context);
            },
            child: Text("Continue")),
      ],
    );
  }

  void beginPayment(BuildContext context) async {
    _waveViewModel.pay(context, widget.currentUser, _tokenResponse.orderId,
        widget.finalAmount, widget.currency, widget.itemIds, widget.merchantId);
  }

  Widget _buildView(BuildContext context, PaymentViewModel payViewModel,
      FlutterWaveViewModel waveViewModel) {
    if (payViewModel.loader == Loader.busy ||
        waveViewModel.state == Loader.busy) {
      return WidgetLoader();
    }
    if (waveViewModel.state == Loader.complete) {
      payViewModel.logTransaction(waveViewModel.transactionLog);
      return _buildBillWidget(context, payViewModel, 'Payment Successful',
          isSuccess: true);
    }
    if (payViewModel.paymentStatus == PaymentStatus.auth) {
      _tokenResponse = payViewModel.getTokenResponse;
      return _buildBillWidget(
          context, payViewModel, 'Authorized, ${_tokenResponse.orderId}');
    }
    return _buildBillWidget(context, payViewModel, 'Please wait, loading');
  }

  void onUpdate(Product p1) {}

  void onDismissed(Product p1) {}

  void _onAmountChange(double value) {}
}
