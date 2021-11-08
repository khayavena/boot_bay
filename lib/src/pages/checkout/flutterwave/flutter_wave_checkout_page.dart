import 'package:bootbay/src/config/EnvConfig.dart';
import 'package:bootbay/src/di/boot_bay_module_locator.dart';
import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/model/merchant_transaction_log.dart';
import 'package:bootbay/src/model/payment_request.dart';
import 'package:bootbay/src/model/token_request.dart';
import 'package:bootbay/src/model/token_response.dart';
import 'package:bootbay/src/pages/checkout/viewmodel/payment_view_model.dart';
import 'package:bootbay/src/wigets/shared/loading/color_loader_4.dart';
import 'package:bootbay/src/wigets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterwave/core/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:flutterwave/utils/flutterwave_constants.dart';
import 'package:provider/provider.dart';

class FlutterCheckoutPage extends StatefulWidget {
  final double finalAmount;
  final String itemIds;
  final String currency;
  final String merchantId;

  @override
  _FlutterCheckoutPageState createState() => _FlutterCheckoutPageState();

  FlutterCheckoutPage(
      {@required this.finalAmount,
      @required this.itemIds,
      @required this.currency,
      @required this.merchantId});
}

class _FlutterCheckoutPageState extends State<FlutterCheckoutPage> {
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
          isAfrica: true));
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
              beginPayment();
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

  void beginPayment() async {
    final Flutterwave flutterWave = Flutterwave.forUIPayment(
        context: this.context,
        encryptionKey: moduleLocator<EnvConfig>().waveEncryptKey,
        publicKey: moduleLocator<EnvConfig>().wavePubKey,
        currency: widget.currency,
        amount: widget.finalAmount.toString(),
        email: "valid@email.com",
        fullName: "Valid Full Name",
        txRef: _tokenResponse.orderId,
        isDebugMode: true,
        phoneNumber: "0123456789",
        acceptCardPayment: true,
        acceptUSSDPayment: false,
        acceptAccountPayment: false,
        acceptFrancophoneMobileMoney: false,
        acceptGhanaPayment: false,
        acceptMpesaPayment: false,
        acceptRwandaMoneyPayment: true,
        acceptUgandaPayment: false,
        acceptZambiaPayment: false);

    try {
      final ChargeResponse response =
          await flutterWave.initializeForUiPayments();
      if (response == null) {
        // user didn't complete the transaction.
      } else {
        final isSuccessful = checkPaymentIsSuccessful(response);
        if (isSuccessful) {
          var logData = MerchantTransactionLog(
              id: _tokenResponse.orderId,
              merchantId: widget.merchantId,
              itemIds: widget.itemIds,
              amount: widget.finalAmount,
              status: 'success');
          _paymentViewModel.logTransaction(logData);
        } else {
          // check message
          print(response.message);

          // check status
          print(response.status);

          // check processor error
          print(response.data.processorResponse);
        }
      }
    } catch (error, stacktrace) {
      // handleError(error);
    }
  }

  bool checkPaymentIsSuccessful(final ChargeResponse response) {
    return response.data.status == FlutterwaveConstants.SUCCESSFUL &&
        response.data.currency == widget.currency &&
        response.data.amount == widget.finalAmount &&
        response.data.txRef == _tokenResponse.orderId;
  }
}
