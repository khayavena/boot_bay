import 'package:bootbay/src/model/PaymentResponse.dart';

abstract class PaymentDao {
  Future<void> insert(PaymentResponse paymentResponse);

  Future<void> update(PaymentResponse paymentResponse);

  Future<List<PaymentResponse>> getPaymentHistory();

}
