import 'package:bootbay/src/model/merchant/merchant.dart';

abstract class MerchantRepository {
  Future<List<Merchant>> getAll();

  Future<Merchant> register(Merchant merchantRequest);

  Future<Merchant> update(Merchant merchantRequest);

  Future<List<Merchant>> getAllByUserId(String userId);
}
