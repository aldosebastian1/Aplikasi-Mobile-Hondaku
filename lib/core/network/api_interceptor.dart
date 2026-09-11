import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer';

class ApiInterceptor extends QueuedInterceptor {
  final FlutterSecureStorage secureStorage;
  final void Function()? onUnauthorized;

  ApiInterceptor(this.secureStorage, {this.onUnauthorized});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      // Dapatkan token segar langsung dari Firebase Auth. 
      // Jika forceRefresh = false, Firebase akan otomatis mengambil dari cache lokal kecuali jika token sudah akan expired.
      final user = FirebaseAuth.instance.currentUser;
      final token = user != null ? await user.getIdToken() : null;
      
      // KEAMANAN & ROBUSTNESS: 
      // Pastikan token benar-benar valid (tidak null & tidak kosong) sebelum disisipkan.
      if (token != null && token.trim().isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      if (kDebugMode) log('❌ Gagal membaca token Firebase: $e');
    }
    
    // KEAMANAN INFORMASI: 
    // Jangan pernah melakukan print/log aktivitas jaringan (terutama Token) di mode Production!
    if (kDebugMode) {
      log('🌐 [REQ] [${options.method}] ${options.uri}');
    }
    
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      log('✅ [RES] [${response.statusCode}] ${response.requestOptions.uri}');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (kDebugMode) {
      log('❌ [ERR] [${err.response?.statusCode}] ${err.requestOptions.uri}');
    }
    
    // PENANGANAN BUG LOGIKA (401 Unauthorized)
    if (err.response?.statusCode == 401) {
      if (kDebugMode) log('⚠️ Sesi Habis (401). Menghapus token basi & memicu Auto-Logout...');
      
      try {
        // Hapus token yang sudah tidak valid demi keamanan sistem
        await secureStorage.delete(key: 'auth_token');
      } catch (e) {
        if (kDebugMode) log('Gagal menghapus token: $e');
      }
      
      // Jika ada aksi yang di-passing dari luar (seperti navigasi ke halaman Login), jalankan.
      if (onUnauthorized != null) {
        onUnauthorized!();
      }
    }
    
    super.onError(err, handler);
  }
}
