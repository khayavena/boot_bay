import 'package:bootbay/src/data/remote/payment/remote_payment_service.dart';
import 'package:bootbay/src/model/PaymentRequest.dart';
import 'package:bootbay/src/model/PaymentResponse.dart';
import 'package:bootbay/src/model/TokenRequest.dart';
import 'package:bootbay/src/model/TokenResponse.dart';
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
}
