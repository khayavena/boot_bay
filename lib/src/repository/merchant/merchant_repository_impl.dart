import 'package:bootbay/src/data/remote/merchant/remote_merchant_data_source.dart';
import 'package:bootbay/src/model/merchant.dart';
import 'package:bootbay/src/repository/merchant/merchant_repository.dart';
import 'package:flutter/foundation.dart';

class MerchantRepositoryImpl implements MerchantRepository {
  final RemoteMerchantDataSource _remoteMerchantDataSource;

  MerchantRepositoryImpl({@required RemoteMerchantDataSource remoteMerchantDataSource})
      : this._remoteMerchantDataSource = remoteMerchantDataSource;

  @override
  Future<List<Merchant>> getAll() {
    return _remoteMerchantDataSource.getAll();
  }
}
