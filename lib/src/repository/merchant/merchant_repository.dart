import 'package:bootbay/src/model/merchant/merchant.dart';

abstract class MerchantRepository {
  Future<List<Merchant>> getAll();

  Future<Merchant> register(Merchant merchantRequest);
}
