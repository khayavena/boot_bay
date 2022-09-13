import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/network_exception.dart';
import 'package:bootbay/src/model/pay_method/model/payment_request.dart';
import 'package:bootbay/src/model/pay_method/model/payment_response.dart';
import 'package:bootbay/src/model/pay_method/model/product.dart';
import 'package:bootbay/src/model/pay_method/model/token_request.dart';
import 'package:bootbay/src/model/pay_method/model/token_response.dart';
import 'package:bootbay/src/model/pay_method/model/user_profile.dart';
import 'package:bootbay/src/pages/checkout/repository/payment_repository.dart';
import 'package:bootbay/src/pages/user/repository/user_repository.dart';
import 'package:bootbay/src/viewmodel/ViewModel.dart';
import 'package:dio/dio.dart';

class PaymentViewModel extends ViewModel {
  UserRepository _userRepository;
  PaymentRepository _paymentRepository;
  List<Product> products = [];
  List<PaymentResponse> _payments = [];
  PaymentResponse _paymentResponse = PaymentResponse();

  late String dataErrorMessage;

  Loader _loader = Loader.idl;
  late PaymentStatus paymentStatus;
  late TokenResponse _tokenResponse;

  PaymentViewModel(
      {required UserRepository userRepository,
      required PaymentRepository paymentRepository})
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
    return _tokenResponse;
  }

  Loader get loader => _loader;

  Future<UserProfile> saveCategory(UserProfile category) {
    return _userRepository.update(category);
  }

  void resetLoader() {
    _loader = Loader.idl;
  }

  void setProducts(List<Product> products) {
    this.products = products;
  }

  void setPaymentSuccess() {
    paymentStatus = PaymentStatus.payment;
    _loader = Loader.complete;
    notifyListeners();
  }

  String getPamentText() {
    switch (_loader) {
      case Loader.error:
        return 'Pay Error';
        break;
      case Loader.busy:
        return 'Pay Busy';
      case Loader.complete:
        return 'Pay Done';
      case Loader.idl:
        return 'Pay Idle';
    }
  }
}

enum PaymentStatus { auth, payment }
