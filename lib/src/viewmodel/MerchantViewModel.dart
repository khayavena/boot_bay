import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/network_exception.dart';
import 'package:bootbay/src/model/merchant.dart';
import 'package:bootbay/src/repository/merchant/merchant_repository.dart';
import 'package:bootbay/src/viewmodel/ViewModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MerchantViewModel extends ViewModel {
  MerchantRepository _merchantRepository;
  Loader _loader;
  List<Merchant> _merchants = [];
  String dataErrorMessage;

  MerchantViewModel({
    @required MerchantRepository merchantRepository,
  }) : _merchantRepository = merchantRepository;

  Future<List<Merchant>> getAllMerchants() async {
    _loader = Loader.busy;
    notifyListeners();
    try {
      _merchants = await _merchantRepository.getAll();
      _loader = Loader.complete;
      notifyListeners();
      return _merchants;
    } on NetworkException catch (error) {
      dataErrorMessage = error.message;
      _loader = Loader.error;
      notifyListeners();
    } on DioError catch (error) {
      _loader = Loader.error;
      handleDioError(error);
    } catch (error) {
      _loader = Loader.error;
      notifyListeners();
    }
    return _merchants;
  }

  List<Merchant> get getMerchants {
    _merchants.add(_merchants[0]);
    _merchants.add(_merchants[0]);
    _merchants.add(_merchants[0]);
    _merchants.add(_merchants[0]);
    _merchants.add(_merchants[0]);
    return _merchants;
  }

  Loader get loader => _loader;
}
