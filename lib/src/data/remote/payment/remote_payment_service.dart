import 'package:bootbay/src/model/pay_method/model/payment_request.dart';
import 'package:bootbay/src/model/pay_method/model/payment_response.dart';
import 'package:bootbay/src/model/pay_method/model/token_request.dart';
import 'package:bootbay/src/model/pay_method/model/token_response.dart';

abstract class RemotePaymentService {
  Future<TokenResponse> getToken(TokenRequest tokenRequest);

  Future<PaymentResponse> pay(PaymentRequest paymentRequest);
}
