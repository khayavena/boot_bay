import 'package:bootbay/src/model/entity_address.dart';
import 'package:bootbay/src/pages/entityaddress/repository/entity_address_repository.dart';

class EntityAddressRepositoryImpl implements EntityAddressRepository {
  @override
  Future<void> delete(String entityId, addressId) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<EntityAddress>> getAddresses(String entityId) {
    // TODO: implement getAddresses
    throw UnimplementedError();
  }

  @override
  Future<EntityAddress> saveAddress(EntityAddress entityAddress) {
    // TODO: implement saveAddress
    throw UnimplementedError();
  }

  @override
  Future<EntityAddress> updateAddress(EntityAddress entityAddress) {
    // TODO: implement updateAddress
    throw UnimplementedError();
  }
}
