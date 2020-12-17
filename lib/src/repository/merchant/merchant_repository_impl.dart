import 'package:bootbay/src/data/remote/merchant/remote_merchant_data_source.dart';
import 'package:bootbay/src/model/merchant/merchant.dart';
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

  @override
  Future<Merchant> register(Merchant merchantRequest) {
    return _remoteMerchantDataSource.register(merchantRequest);
  }

  @override
  Future<Merchant> update(Merchant merchantRequest) {
    return _remoteMerchantDataSource.update(merchantRequest);
  }

  @override
  Future<List<Merchant>> getAllByUserId(String userId) {
    return _remoteMerchantDataSource.getAllByUserId( userId);
  }
}
