import 'package:bootbay/src/enum/loading_enum.dart';
import 'package:bootbay/src/model/entity_address.dart';
import 'package:bootbay/src/pages/entityaddress/repository/entity_address_repository.dart';
import 'package:bootbay/src/viewmodel/ViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';

class EntityAddressViewModel extends ViewModel {
  final EntityAddressRepository _addressRepository;
  Loader status = Loader.idl;
  EntityAddress _entityAddress;
  List<EntityAddress> _entityAddresses;

  EntityAddressViewModel({@required EntityAddressRepository addressRepository})
      : _addressRepository = addressRepository;

  Future<List<EntityAddress>> getAddresses(String entityId) async {
    status = Loader.busy;
    notifyListeners();
    var results = await _addressRepository.getAddresses(entityId);
    if (results != null && results.isNotEmpty) {
      status = Loader.complete;
    } else {
      status = Loader.error;
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
    _entityAddress = null;
  }

  void updateSelectedAddress(final String parentId, final MapBoxPlace maxBoxPlace) {
    if (_entityAddress == null) {
      _entityAddress = new EntityAddress(
          parentId: parentId,
          address: maxBoxPlace.placeName,
          latitude: maxBoxPlace.geometry.coordinates[0],
          longitude: maxBoxPlace.geometry.coordinates[1]);
    } else {
      _entityAddress = new EntityAddress(
          id: _entityAddress.id,
          parentId: parentId,
          address: maxBoxPlace.placeName,
          latitude: maxBoxPlace.geometry.coordinates[0],
          longitude: maxBoxPlace.geometry.coordinates[1]);
    }
  }
}
