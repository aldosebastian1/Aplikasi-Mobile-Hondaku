import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../domain/models/motorcycle.dart';
import '../../domain/repositories/motorcycle_repository.dart';
import '../../core/network/api_response.dart';
import 'dart:developer';

// --- FUNGSI ISOLATE (Background Thread) ---
// Standar Super App: Parsing list besar TIDAK BOLEH dilakukan di Main Thread UI.
// Fungsi ini harus berada di luar kelas (Top-level) agar bisa dilempar ke core CPU lain.
List<Motorcycle> _parseMotorcyclesInBackground(List<dynamic> rawData) {
  return rawData
      .map((item) => Motorcycle.fromJson(item as Map<String, dynamic>))
      .toList();
}

class ApiMotorcycleRepositoryImpl implements MotorcycleRepository {
  final Dio dio;

  ApiMotorcycleRepositoryImpl(this.dio);

  @override
  Future<List<Motorcycle>> getMotorcycles() async {
    try {
      // Tambahkan limit=100 agar semua data dari database (termasuk CUB & EV) tertarik ke halaman Home
      final response = await dio.get('/motorcycles?limit=100');

      final apiResponse = ApiResponse<List<dynamic>>.fromJson(
        response.data,
        (data) => data as List<dynamic>,
      );

      if (!apiResponse.status || apiResponse.data == null) {
        throw Exception(apiResponse.message.isNotEmpty 
            ? apiResponse.message 
            : 'Gagal memuat katalog motor.');
      }

      // PERFORMA EKSTREM:
      // Menggunakan `compute` untuk mengalihkan proses loop/mapping ke Background Isolate.
      // Jika server mengirim 10.000 data, layar pengguna tidak akan patah-patah (Jank-Free 120fps).
      final motorcycles = await compute(_parseMotorcyclesInBackground, apiResponse.data!);

      return motorcycles;
      
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      if (kDebugMode) log('🔥 Crash Prevented in getMotorcycles: $e');
      throw Exception('Terjadi kesalahan pemrosesan format data internal.');
    }
  }

  @override
  Future<Motorcycle?> getMotorcycleById(String id) async {
    try {
      final response = await dio.get('/motorcycles/$id');

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(
        response.data,
        (data) => data as Map<String, dynamic>,
      );

      if (!apiResponse.status || apiResponse.data == null) {
        throw Exception(apiResponse.message);
      }

      // Objek tunggal sangat ringan, aman di-parsing langsung di Main Thread
      return Motorcycle.fromJson(apiResponse.data!);
      
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      if (kDebugMode) log('🔥 Crash Prevented in getMotorcycleById: $e');
      throw Exception('Terjadi kesalahan pemrosesan data spesifik.');
    }
  }

  // Helper untuk Exception yang ramah pengguna
  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Koneksi internet lambat. Silakan coba lagi.');
      case DioExceptionType.badResponse:
        final errorMsg = e.response?.data?['message'] ?? 'Terjadi kesalahan pada server.';
        return Exception(errorMsg);
      case DioExceptionType.connectionError:
        return Exception('Tidak ada koneksi internet. Periksa sinyal Anda.');
      default:
        return Exception('Gagal menghubungi server. Terjadi kendala teknis.');
    }
  }
}

