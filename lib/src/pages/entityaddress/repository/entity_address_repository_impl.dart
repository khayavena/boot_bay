import 'package:bootbay/src/data/remote/entity_address/entity_address_data_source.dart';
import 'package:bootbay/src/model/entity_address.dart';
import 'package:bootbay/src/pages/entityaddress/repository/entity_address_repository.dart';
import 'package:flutter/cupertino.dart';

class EntityAddressRepositoryImpl implements EntityAddressRepository {
  final RemoteEntityAddressDataSource _addressDataSource;

  EntityAddressRepositoryImpl({@required RemoteEntityAddressDataSource addressDataSource})
      : this._addressDataSource = addressDataSource;

  @override
  Future<void> delete(String entityId, addressId) async {
    return await _addressDataSource.delete(entityId, addressId);
  }

  @override
  Future<List<EntityAddress>> getAddresses(String entityId) async {
    return await _addressDataSource.getAddresses(entityId);
  }

  @override
  Future<EntityAddress> saveAddress(EntityAddress entityAddress) async {
    return await _addressDataSource.saveAddress(entityAddress);
  }

  @override
  Future<EntityAddress> updateAddress(EntityAddress entityAddress) async {
    return await _addressDataSource.saveAddress(entityAddress);
  }
}
