import 'package:bootbay/src/data/local/payment/payment_dao.dart';
import 'package:bootbay/src/data/remote/payment/remote_payment_service.dart';
import 'package:bootbay/src/helpers/network_helper.dart';
import 'package:bootbay/src/model/payment_request.dart';
import 'package:bootbay/src/model/payment_response.dart';
import 'package:bootbay/src/model/token_request.dart';
import 'package:bootbay/src/model/token_response.dart';
import 'package:bootbay/src/pages/checkout/repository/payment_repository.dart';
import 'package:flutter/material.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  RemotePaymentService _paymentService;
  PaymentDao _paymentDao;
  NetworkHelper _networkHelper;

  PaymentRepositoryImpl(
      {@required RemotePaymentService paymentService,
      @required NetworkHelper networkHelper,
      @required PaymentDao paymentDao})
      : _paymentService = paymentService,
        _networkHelper = networkHelper,
        _paymentDao = paymentDao;

  @override
  Future<List<PaymentResponse>> getAll() {
    return _paymentDao.getPaymentHistory();
  }

  @override
  Future<TokenResponse> getToken(TokenRequest tokenRequest) {
    return _paymentService.getToken(tokenRequest);
  }

  @override
  Future<PaymentResponse> pay(PaymentRequest paymentRequest) {
    return _paymentService.pay(paymentRequest).then((value) {
      _paymentDao.insert(value);
      return value;
    });
  }
}
