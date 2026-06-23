import '../../domain/models/bank_option.dart';
import '../../domain/repositories/bank_repository.dart';
import '../bank_data.dart';

class BankRepositoryImpl implements BankRepository {
  @override
  Future<List<BankOption>> getBankOptions() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return bankOptions;
  }
}
