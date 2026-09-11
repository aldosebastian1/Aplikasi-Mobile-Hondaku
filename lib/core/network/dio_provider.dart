import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'api_interceptor.dart';

// Provider untuk Secure Storage (Penyimpanan token yang dienkripsi)
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

// Provider untuk Dio (Jantung Network Client kita)
final dioProvider = Provider<Dio>((ref) {
  // STRICT VALIDATION (Gojek/Grab Standard):
  // Jangan pernah memberikan 'fallback' hardcode jika URL hilang. 
  // Lebih baik aplikasi melempar error dengan jelas daripada diam-diam menembak server yang salah.
  final baseUrl = dotenv.env['API_BASE_URL'];
  
  if (baseUrl == null || baseUrl.trim().isEmpty) {
    throw Exception('🔥 FATAL ERROR: API_BASE_URL tidak didefinisikan di file .env!');
  }

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl, 
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      // Menerima berbagai jenis format data dengan aman, pastikan selalu berupa JSON
      responseType: ResponseType.json,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  // Memasang "Satpam" (Interceptor) ke dalam Dio
  dio.interceptors.add(
    ApiInterceptor(
      ref.watch(secureStorageProvider),
      onUnauthorized: () {
        // TODO: Panggil fungsi ref.read(authNotifierProvider.notifier).signOut()
        // Ini akan kita hubungkan nanti agar otomatis melempar user ke halaman Login
      },
    ),
  );

  return dio;
});
