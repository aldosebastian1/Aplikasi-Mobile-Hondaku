import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/news_article.dart';
import '../../domain/repositories/news_repository.dart';

// Provider for the Dio instance so we can easily mock it if needed
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://dummyjson.com',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));
  return dio;
});

// Provider for the NewsRepository
final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return NewsRepositoryImpl();
});

class NewsRepositoryImpl implements NewsRepository {
  NewsRepositoryImpl();

  @override
  Future<List<NewsArticle>> fetchLatestNews() async {
    try {
      // Menggunakan data mock berita berbahasa Indonesia
      await Future.delayed(const Duration(seconds: 1)); // Simulasi network delay
      return [
        const NewsArticle(
          id: 1,
          title: 'Vario 160 | Tampil Lebih Sporty',
          body: 'Varian warna matte terbaru Vario 160 resmi mengaspal makin agresif.',
        ),
        const NewsArticle(
          id: 2,
          title: 'Tips Ahli | Rawat Mesin Injeksi',
          body: 'Jaga performa optimal mesin injeksi Anda dengan rutin servis berkala.',
        ),
        const NewsArticle(
          id: 3,
          title: 'Klub CB150R | Touring Lintas Pulau',
          body: 'Komunitas CB150R sukses gelar touring meriah lintas pulau Jawa & Bali.',
        ),
      ];
    } on DioException catch (e) {
      // Demonstrating HTTP Error Handling with Dio
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Koneksi timeout. Silakan periksa internet Anda.');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception('Server sedang mengalami gangguan sementara. Silakan coba lagi nanti.');
      } else {
        throw Exception('Terjadi kesalahan jaringan. Pastikan perangkat Anda terhubung ke internet.');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan tidak terduga pada sistem.');
    }
  }
}
