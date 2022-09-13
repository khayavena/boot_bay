import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/model/entity_address.dart';
import 'package:bootbay/src/pages/entityaddress/repository/entity_address_repository.dart';
import 'package:bootbay/src/viewmodel/ViewModel.dart';

class EntityAddressViewModel extends ViewModel {
  final EntityAddressRepository _addressRepository;
  Loader status = Loader.idl;
  late EntityAddress _entityAddress = EntityAddress();
  late List<EntityAddress> _entityAddresses;

  EntityAddressViewModel({required EntityAddressRepository addressRepository})
      : _addressRepository = addressRepository;

  Future<List<EntityAddress>> getAddresses(String entityId) async {
    status = Loader.busy;
    notifyListeners();
    _entityAddresses = await _addressRepository.getAddresses(entityId);
    notifyListeners();
    return _entityAddresses;
  }

  Future<EntityAddress> saveAddress(EntityAddress entityAddress) async {
    status = Loader.busy;
    notifyListeners();
    var results = await _addressRepository.saveAddress(entityAddress);
    status = Loader.complete;
    notifyListeners();
    return results;
  }

  Future<EntityAddress> updateAddress(EntityAddress entityAddress) async {
    status = Loader.busy;
    notifyListeners();
    var results = await _addressRepository.updateAddress(entityAddress);
    status = Loader.complete;
    notifyListeners();
    return results;
  }

  Future<List<EntityAddress>> getAll(String entityId) async {
    status = Loader.busy;
    notifyListeners();
    var results = await _addressRepository.getAddresses(entityId);
    for (var address in results) {
      if (address.selected) {
        _entityAddress = address;
        break;
      }
    }
    status = Loader.complete;
    notifyListeners();
    return results;
  }

  Future<void> delete(String entityId, addressId) async {
    status = Loader.busy;
    notifyListeners();
    await _addressRepository.delete(entityId, addressId);
    status = Loader.complete;
    notifyListeners();
  }

  List<EntityAddress> get entityAddresses => _entityAddresses;

  EntityAddress get entityAddress => _entityAddress;

  void clear() {
    status = Loader.idl;
    _entityAddresses = [];
  }

  void setAddress(EntityAddress saveAddress) {
    this._entityAddress = saveAddress;
  }
}
