import 'package:bootbay/src/model/merchant.dart';

abstract class MerchantRepository {
  Future<List<Merchant>> getAll();
}
