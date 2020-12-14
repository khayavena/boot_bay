import 'package:bootbay/src/model/merchant.dart';

abstract class RemoteMerchantDataSource {
  Future<List<Merchant>> getAll();
}
