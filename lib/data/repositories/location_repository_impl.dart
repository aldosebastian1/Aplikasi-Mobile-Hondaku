import 'package:dio/dio.dart';
import '../../domain/models/kecamatan.dart';
import '../../domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final Dio dio;

  LocationRepositoryImpl(this.dio);

  @override
  Future<List<Kecamatan>> getKecamatans() async {
    try {
      final response = await dio.get('/locations');
      final data = response.data as List<dynamic>;
      return data.map((json) => Kecamatan.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Gagal mengambil data wilayah. Pastikan koneksi internet Anda stabil.');
    }
  }
}
