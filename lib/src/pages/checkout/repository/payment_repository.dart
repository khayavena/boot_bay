import 'package:bootbay/src/model/pay_method/model/payment_request.dart';
import 'package:bootbay/src/model/pay_method/model/payment_response.dart';
import 'package:bootbay/src/model/pay_method/model/token_request.dart';
import 'package:bootbay/src/model/pay_method/model/token_response.dart';

abstract class PaymentRepository {
  Future<TokenResponse> getToken(TokenRequest user);

  Future<PaymentResponse> pay(PaymentRequest paymentRequest);

  Future<List<PaymentResponse>> getAll();
}
