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
  final dio = ref.watch(dioProvider);
  return NewsRepositoryImpl(dio);
});

class NewsRepositoryImpl implements NewsRepository {
  final Dio _dio;

  NewsRepositoryImpl(this._dio);

  @override
  Future<List<NewsArticle>> fetchLatestNews() async {
    try {
      // Using DummyJSON API to simulate fetching automotive news
      final response = await _dio.get('/posts', queryParameters: {'limit': 5});
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['posts'];
        return data.map((json) => NewsArticle.fromJson(json)).toList();
      } else {
        throw Exception('Gagal mengambil berita terbaru dari server. Silakan coba sesaat lagi.');
      }
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
