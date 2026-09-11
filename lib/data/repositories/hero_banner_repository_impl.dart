import 'package:dio/dio.dart';
import '../../domain/models/hero_banner.dart';
import '../../domain/repositories/hero_banner_repository.dart';

class HeroBannerRepositoryImpl implements HeroBannerRepository {
  final Dio dio;

  HeroBannerRepositoryImpl(this.dio);

  @override
  Future<List<HeroBanner>> getHeroBanners() async {
    try {
      final response = await dio.get('/banners');
      final data = response.data as List<dynamic>;
      return data.map((json) => HeroBanner.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Gagal memuat promo terbaru. Silakan periksa koneksi Anda.');
    }
  }
}
