import 'package:bootbay/src/data/remote/merchant/remote_merchant_data_source.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
import 'package:bootbay/src/model/merchant/merchant_response.dart';
import 'package:dio/dio.dart';

class RemoteMerchantDataSourceImpl implements RemoteMerchantDataSource {
  final Dio _dioClient;

  RemoteMerchantDataSourceImpl({required Dio dioClient})
      : _dioClient = dioClient;

  @override
  Future<List<Merchant>> getAll() async {
    Response response = await _dioClient.get('/api/merchant/all');
    return List<Merchant>.from(
        response.data.map((json) => Merchant.fromJson(json)));
  }

  @override
  Future<Merchant> register(Merchant merchantRequest) async {
    Response response = await _dioClient.post('/api/merchant/register',
        data: merchantRequest.toJson());
    final results = response.data;
    return Merchant.fromJson(results);
  }

  @override
  Future<Merchant> update(Merchant merchantRequest) async {
    Response response = await _dioClient.post('/api/merchant/update',
        data: merchantRequest.toJson());
    return MerchantResponse.fromJson(response.data).merchant;
  }

  @override
  Future<List<Merchant>> getAllByUserId(String userId) async {
    Response response = await _dioClient.get('/api/merchant/all/$userId');
    return List<Merchant>.from(
        response.data.map((json) => Merchant.fromJson(json)));
  }
}
