import 'package:dio/dio.dart';
import '../../domain/models/bank_option.dart';
import '../../domain/repositories/bank_repository.dart';

class BankRepositoryImpl implements BankRepository {
  final Dio dio;

  BankRepositoryImpl(this.dio);

  @override
  Future<List<BankOption>> getBankOptions() async {
    try {
      final response = await dio.get('/banks');
      final data = response.data as List<dynamic>;
      return data.map((json) => BankOption.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Gagal mengambil daftar bank. Pastikan koneksi internet Anda stabil.');
    }
  }
}
