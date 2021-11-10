import 'package:bootbay/src/config/EnvConfig.dart';
import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/model/merchant_transaction_log.dart';
import 'package:bootbay/src/model/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterwave/core/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:flutterwave/utils/flutterwave_constants.dart';

class FlutterWaveViewModel extends ChangeNotifier {
  Loader _state = Loader.idl;
  MerchantTransactionLog _transactionLog;
  String _message;
  final EnvConfig _envConfig;

  FlutterWaveViewModel({@required EnvConfig envConfig})
      : _envConfig = envConfig;

  void pay(
      BuildContext context,
      UserProfile currentUser,
      String orderId,
      double finalAmount,
      String currency,
      String itemIds,
      String merchantId) async {
    var flutterWave = Flutterwave.forUIPayment(
        context: context,
        encryptionKey: _envConfig.waveEncryptKey,
        publicKey: _envConfig.wavePubKey,
        currency: currency,
        amount: finalAmount.toString(),
        email: currentUser.email,
        fullName: currentUser.fullName,
        txRef: orderId,
        isDebugMode: true,
        phoneNumber: '0640231798',
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
      var response = await flutterWave.initializeForUiPayments();

      if (response == null) {
        // user didn't complete the transaction.
      } else {
        final isSuccessful = checkPaymentIsSuccessful(
            response, currency, finalAmount.toString(), orderId);
        if (isSuccessful) {
          _transactionLog = MerchantTransactionLog(
              id: orderId,
              merchantId: merchantId,
              itemIds: itemIds,
              amount: finalAmount,
              status: 'success');
          setState(Loader.complete);
        } else {
          // check message
          print(response.message);

          // check status
          print(response.status);

          // check processor error
          print(response.data.processorResponse);
          setState(Loader.error);
        }
      }
    } catch (error, stacktrace) {
      // handleError(error);
    }
  }

  bool checkPaymentIsSuccessful(final ChargeResponse response, String currency,
      String finalAmount, String orderId) {
    return response.data.status == FlutterwaveConstants.SUCCESSFUL &&
        response.data.currency == currency &&
        response.data.amount == finalAmount &&
        response.data.txRef == orderId;
  }

  Loader get state => _state;

  MerchantTransactionLog get transactionLog => _transactionLog;

  void setState(Loader state) {
    _state = state;
    notifyListeners();
  }
}
