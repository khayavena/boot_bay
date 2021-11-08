import 'package:bootbay/src/data/remote/payment/remote_payment_service.dart';
import 'package:bootbay/src/model/merchant_transaction_log.dart';
import 'package:bootbay/src/model/payment_request.dart';
import 'package:bootbay/src/model/payment_response.dart';
import 'package:bootbay/src/model/token_request.dart';
import 'package:bootbay/src/model/token_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RemotePaymentServiceImpl<T> implements RemotePaymentService {
  Dio _dio;

  RemotePaymentServiceImpl({
    @required Dio dio,
  }) : _dio = dio;

  @override
  Future<TokenResponse> getToken(TokenRequest tokenRequest) async {
    Response response =
        await _dio.post('/api/payment/tokenize', data: tokenRequest.toJson());
    return TokenResponse.fromJson(response.data);
  }

  @override
  Future<PaymentResponse> pay(PaymentRequest paymentRequest) async {
    Response response =
        await _dio.post('/api/payment/checkout', data: paymentRequest.toJson());
    return PaymentResponse.fromJson(response.data);
  }

  @override
  Future<MerchantTransactionLog> logTransaction(MerchantTransactionLog logData) {
    // TODO: implement logTransaction
    throw UnimplementedError();
  }
}
