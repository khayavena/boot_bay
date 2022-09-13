import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/helpers/network_exception.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/pages/merchant/repository/merchant_repository.dart';
import 'package:bootbay/src/viewmodel/ViewModel.dart';
import 'package:dio/dio.dart';

class MerchantRegistrationViewModel extends ViewModel {
  MerchantRepository _merchantRepository;
  Loader _loader = Loader.idl;
  Merchant _merchant = Merchant();
  String dataErrorMessage = "";

  MerchantRegistrationViewModel({
    required MerchantRepository merchantRepository,
  }) : _merchantRepository = merchantRepository;

  Merchant get getMerchant {
    return _merchant;
  }

  Loader get status => _loader;

  void resetLoader() {
    _loader = Loader.idl;
  }

  Future<Merchant> register(Merchant merchantRequest) async {
    _loader = Loader.busy;
    notifyListeners();
    try {
      _merchant = await _merchantRepository.register(merchantRequest);
      _loader = Loader.complete;
      notifyListeners();
      return _merchant;
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
    return _merchant;
  }
}
