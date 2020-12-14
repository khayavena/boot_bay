import 'package:bootbay/src/data/remote/merchant/remote_merchant_data_source.dart';
import 'package:bootbay/src/model/merchant.dart';
import 'package:dio/dio.dart';

class RemoteMerchantDataSourceImpl implements RemoteMerchantDataSource {
  final Dio _dioClient;

  RemoteMerchantDataSourceImpl({Dio dioClient}) : _dioClient = dioClient;

  @override
  Future<List<Merchant>> getAll() async {
    Response response = await _dioClient.get('/api/merchant/all');

    return List<Merchant>.from(response.data.map((json) => Merchant.fromJson(json)));
  }
}
