import 'package:bootbay/src/model/merchant_transaction_log.dart';
import 'package:bootbay/src/model/payment_request.dart';
import 'package:bootbay/src/model/payment_response.dart';
import 'package:bootbay/src/model/token_request.dart';
import 'package:bootbay/src/model/token_response.dart';

abstract class RemotePaymentService {
  Future<TokenResponse> getToken(TokenRequest tokenRequest);

  Future<PaymentResponse> pay(PaymentRequest paymentRequest);

  Future<MerchantTransactionLog> logTransaction(MerchantTransactionLog logData);
}
