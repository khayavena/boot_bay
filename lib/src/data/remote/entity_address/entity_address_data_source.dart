import 'package:bootbay/src/model/entity_address.dart';

abstract class RemoteEntityAddressDataSource {
  Future<List<EntityAddress>> getAddresses(String entityId);

  Future<EntityAddress> saveAddress(EntityAddress entityAddress);

  Future<EntityAddress> updateAddress(EntityAddress entityAddress);

  Future<void> delete(String entityId, addressId);
}
