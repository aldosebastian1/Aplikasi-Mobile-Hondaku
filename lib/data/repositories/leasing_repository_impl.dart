import 'package:dio/dio.dart';
import '../../domain/models/leasing_parameter.dart';
import '../../domain/repositories/leasing_repository.dart';

class LeasingRepositoryImpl implements LeasingRepository {
  final Dio dio;

  LeasingRepositoryImpl(this.dio);

  @override
  Future<List<LeasingParameter>> getLeasingParameters() async {
    try {
      final response = await dio.get('/leasing');
      final data = response.data as List<dynamic>;
      return data.map((json) => LeasingParameter.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Gagal mengambil parameter leasing. Pastikan koneksi internet Anda stabil.');
    }
  }
}
