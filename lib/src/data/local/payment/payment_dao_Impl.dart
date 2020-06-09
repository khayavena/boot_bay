import 'package:bootbay/src/data/local/payment/payment_dao.dart';
import 'package:bootbay/src/model/PaymentResponse.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';

class PaymentDaoImpl implements PaymentDao {
  static const String folderName = "Payment";
  final _paymentStore = intMapStoreFactory.store(folderName);
  Database _database;

  PaymentDaoImpl({
    @required Database database,
  }) : _database = database;

  @override
  Future<List<PaymentResponse>> getPaymentHistory() async {
    final recordSnapshot = await _paymentStore.find(_database);
    return recordSnapshot.map((snapshot) {
      final student = PaymentResponse.fromJson(snapshot.value);
      return student;
    }).toList();
  }

  @override
  Future<void> insert(PaymentResponse paymentResponse) async {
    int b = await _paymentStore.add(_database, paymentResponse.toJson());
    print('PaymentResponse status $b');
  }

  @override
  Future<void> update(PaymentResponse paymentResponse) async {
    var finder = Finder(
      filter: Filter.equals('id', paymentResponse.id),
    );
    int b = await _paymentStore.update(_database, paymentResponse.toJson(),
        finder: finder);
    print('PaymentResponse status $b');
  }
}
