import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/network_exception.dart';
import 'package:bootbay/src/model/PaymentRequest.dart';
import 'package:bootbay/src/model/PaymentResponse.dart';
import 'package:bootbay/src/model/TokenRequest.dart';
import 'package:bootbay/src/model/TokenResponse.dart';
import 'package:bootbay/src/model/User.dart';
import 'package:bootbay/src/repository/payment/payment_repository.dart';
import 'package:bootbay/src/repository/user/user_repository.dart';
import 'package:bootbay/src/viewmodel/ViewModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PaymentViewModel extends ViewModel {
  UserRepository _userRepository;
  PaymentRepository _paymentRepository;

  List<PaymentResponse> _payments = [];
  PaymentResponse _paymentResponse = PaymentResponse();

  String dataErrorMessage;

  Loader _loader = Loader.idl;
  PaymentStatus paymentStatus;
  TokenResponse _tokenResponse;

  PaymentViewModel({@required UserRepository userRepository, @required PaymentRepository paymentRepository})
      : _userRepository = userRepository,
        _paymentRepository = paymentRepository;

  Future<List<PaymentResponse>> getAllPayments() async {
    _loader = Loader.busy;
    try {
      _payments = await _paymentRepository.getAll();
      _loader = Loader.complete;
      notifyListeners();
      return _payments;
    } on NetworkException catch (error) {
      _loader = Loader.error;
      dataErrorMessage = error.message;
      notifyListeners();
    } on DioError catch (error) {
      _loader = Loader.error;
      handleDioError(error);
    } catch (error) {
      _loader = Loader.error;
      notifyListeners();
    }
    return _payments;
  }

  List<PaymentResponse> get getPayments => _payments;

  PaymentResponse get getPaymentResponse => _paymentResponse;

  TokenResponse get getTokenResponse => _tokenResponse;

  Future<PaymentResponse> pay(PaymentRequest paymentRequest) async {
    _loader = Loader.busy;
    paymentStatus = PaymentStatus.payment;
    notifyListeners();
    try {
      _paymentResponse = await _paymentRepository.pay(paymentRequest);
      _loader = Loader.complete;
      notifyListeners();
    } on NetworkException catch (error) {
      _loader = Loader.error;
      dataErrorMessage = error.message;
      notifyListeners();
    } on DioError catch (error) {
      _loader = Loader.error;
      handleDioError(error);
    } catch (error) {
      _loader = Loader.error;
      notifyListeners();
    }
    return _paymentResponse;
  }

  Future<TokenResponse> getToken(TokenRequest tokenRequest) async {
    _loader = Loader.busy;
    paymentStatus = PaymentStatus.auth;
    notifyListeners();
    try {
      _tokenResponse = await _paymentRepository.getToken(tokenRequest);
      _loader = Loader.complete;
      notifyListeners();
      return _tokenResponse;
    } on NetworkException catch (error) {
      _loader = Loader.error;
      dataErrorMessage = error.message;
      notifyListeners();
    } on DioError catch (error) {
      _loader = Loader.error;
      handleDioError(error);
    } catch (error) {
      _loader = Loader.error;
      notifyListeners();
    }
  }

  Loader get loader => _loader;

  Future<User> saveCategory(User category) {
    return _userRepository.update(category);
  }

  void resetLoader() {
    _loader = Loader.idl;
  }
}

enum PaymentStatus { auth, payment }
