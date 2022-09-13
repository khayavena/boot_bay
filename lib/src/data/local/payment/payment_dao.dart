import 'package:bootbay/src/model/pay_method/model/payment_response.dart';

abstract class PaymentDao {
  Future<void> insert(PaymentResponse paymentResponse);

  Future<void> update(PaymentResponse paymentResponse);

  Future<List<PaymentResponse>> getPaymentHistory();

}
