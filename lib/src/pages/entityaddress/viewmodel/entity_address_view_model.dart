import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/model/entity_address.dart';
import 'package:bootbay/src/pages/entityaddress/repository/entity_address_repository.dart';
import 'package:bootbay/src/viewmodel/ViewModel.dart';

class EntityAddressViewModel extends ViewModel {
  final EntityAddressRepository _addressRepository;
  Loader status = Loader.idl;
  late EntityAddress _entityAddress;
  late List<EntityAddress> _entityAddresses;

  EntityAddressViewModel({required EntityAddressRepository addressRepository})
      : _addressRepository = addressRepository;

  Future<List<EntityAddress>> getAddresses(String entityId) async {
    status = Loader.busy;
    notifyListeners();
    var results = await _addressRepository.getAddresses(entityId);
    if (results.isNotEmpty) {
      status = Loader.complete;
    } else {
      status = Loader.complete;
    }
    notifyListeners();
    return results;
  }

  Future<EntityAddress> saveAddress(EntityAddress entityAddress) async {
    status = Loader.busy;
    notifyListeners();
    var results = await _addressRepository.saveAddress(entityAddress);
    if (results != null) {
      status = Loader.complete;
    } else {
      status = Loader.error;
    }
    notifyListeners();
    return results;
  }

  Future<EntityAddress> updateAddress(EntityAddress entityAddress) async {
    status = Loader.busy;
    notifyListeners();
    var results = await _addressRepository.updateAddress(entityAddress);
    if (results != null) {
      status = Loader.complete;
    } else {
      status = Loader.error;
    }
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
    if (results != null) {
      status = Loader.complete;
    } else {
      status = Loader.error;
    }
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

  void updateSelectedAddress(final String parentId, final String placeName,
      double latitude, double longitude, String type) {
    if (_entityAddress.id.isNotEmpty) {
      _entityAddress = EntityAddress(
          parentId: parentId,
          type: type,
          address: placeName,
          latitude: latitude,
          longitude: longitude);
    } else {
      _entityAddress = EntityAddress(
          id: _entityAddress.id,
          parentId: parentId,
          type: type,
          address: placeName,
          latitude: latitude,
          longitude: longitude);
    }
  }
}
