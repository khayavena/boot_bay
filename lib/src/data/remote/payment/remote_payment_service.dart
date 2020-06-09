import 'package:bootbay/src/model/PaymentRequest.dart';
import 'package:bootbay/src/model/PaymentResponse.dart';
import 'package:bootbay/src/model/TokenRequest.dart';
import 'package:bootbay/src/model/TokenResponse.dart';

abstract class RemotePaymentService {
  Future<TokenResponse> getToken(TokenRequest tokenRequest);

  Future<PaymentResponse> pay(PaymentRequest paymentRequest);
}
