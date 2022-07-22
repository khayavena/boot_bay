import 'package:bootbay/src/data/remote/entity_address/entity_address_data_source.dart';
import 'package:bootbay/src/model/entity_address.dart';
import 'package:dio/dio.dart';

class RemoteEntityAddressDataSourceImpl
    implements RemoteEntityAddressDataSource {
  static const _base = '/api/address';
  final Dio _dio;

  RemoteEntityAddressDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<void> delete(String entityId, addressId) async {
    // var path = '/address/$entityId/entity/$addressId';
    // var response = await _dio.get(path);
  }

  @override
  Future<List<EntityAddress>> getAddresses(String entityId) async {
    var path = '$_base/all/$entityId';
    var response = await _dio.get(path);
    return List<EntityAddress>.from(
        response.data.map((json) => EntityAddress.fromJson(json)));
  }

  @override
  Future<EntityAddress> saveAddress(EntityAddress entityAddress) async {
    var path = '$_base/save';
    var response = await _dio.post(path, data: entityAddress.toJson());
    return EntityAddress.fromJson(response.data);
  }

  @override
  Future<EntityAddress> updateAddress(EntityAddress entityAddress) async {
    var path = '$_base/update';
    var response = await _dio.post(path, data: entityAddress.toJson());
    return EntityAddress.fromJson(response.data);
  }
}
