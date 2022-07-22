import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/network_exception.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/pages/merchant/repository/merchant_repository.dart';
import 'package:bootbay/src/viewmodel/ViewModel.dart';
import 'package:dio/dio.dart';

class MerchantViewModel extends ViewModel {
  MerchantRepository _merchantRepository;
  Loader _loader = Loader.idl;
  List<Merchant> _merchants = [];

  MerchantViewModel({
    required MerchantRepository merchantRepository,
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

  Future<List<Merchant>> getAllMerchantsByUserId(String userId) async {
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
    return _merchants;
  }

  Loader get loader => _loader;

  void resetLoader() {
    _loader = Loader.idl;
  }
}
