import 'package:bootbay/src/model/PaymentRequest.dart';
import 'package:bootbay/src/model/PaymentResponse.dart';
import 'package:bootbay/src/model/TokenRequest.dart';
import 'package:bootbay/src/model/TokenResponse.dart';

abstract class PaymentRepository {
  Future<TokenResponse> getToken(TokenRequest user);

  Future<PaymentResponse> pay(PaymentRequest paymentRequest);

  Future<List<PaymentResponse>> getAll();
}
