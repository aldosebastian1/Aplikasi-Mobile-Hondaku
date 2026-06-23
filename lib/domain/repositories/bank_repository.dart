import '../models/bank_option.dart';

abstract class BankRepository {
  Future<List<BankOption>> getBankOptions();
}
