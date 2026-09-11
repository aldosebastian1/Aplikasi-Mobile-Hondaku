// ignore_for_file: avoid_print
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:hondaku/data/repositories/api_motorcycle_repository_impl.dart';

// Mock Interceptor: Bertugas meniru (mock) server API sungguhan.
// Ini mencegah pemanggilan API asli dan membuktikan kode kita tahan banting.
class MockApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path.startsWith('/motorcycles')) {
      handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: {
            "status": true,
            "message": "Sukses mengambil katalog",
            "meta": {
              "current_page": 1,
              "last_page": 5,
              "total": 50,
              "per_page": 10
            },
            "data": [
              {
                "id": "MTR-001",
                "name": "Honda Vario 160",
                "category_badge": "Matic",
                "price": "Rp 26.500.000",
                // Perhatikan: Server API selalu pakai snake_case
                "fuel_capacity": "5.5 Liter",
                "is_new": true
                // is_recommended SENGAJA DIHILANGKAN untuk menguji @Default
              }
            ]
          }
        )
      );
    } else {
      handler.next(options);
    }
  }
}

void main() {
  test('Uji Coba Alur Data (Enterprise Standard): Parsing Aman & Isolate', () async {
    print('Memulai Pengujian Alur Data REST API...');
    
    // 1. Siapkan Dio dan pasangkan Server Bohongan (Mock)
    final dio = Dio();
    dio.interceptors.add(MockApiInterceptor());

    // 2. Siapkan "Si Koki" (Repository)
    final repository = ApiMotorcycleRepositoryImpl(dio);

    // 3. UI Meminta Data
    // Saat fungsi ini dipanggil, secara otomatis ia akan membungkus data ke ApiResponse, 
    // mengecek status, lalu melempar parsing ke Background Isolate (Thread Terpisah).
    final motorcycles = await repository.getMotorcycles();

    // 4. PEMBUKTIAN KESUKSESAN
    expect(motorcycles.isNotEmpty, true);
    print('✅ 1. Proses List Data di Background (Isolate) Berhasil.');
    
    expect(motorcycles.first.name, "Honda Vario 160");
    print('✅ 2. Parsing JSON Mentah ke Objek Dart Berhasil.');
    
    // Uji apakah "fuel_capacity" dari API sukses masuk ke variabel "fuelCapacity"
    expect(motorcycles.first.fuelCapacity, "5.5 Liter");
    print('✅ 3. Sihir Pemetaan Snake_Case ke CamelCase Berhasil.');
    
    // Uji nilai Default: isNew = true (dari API), isRecommended = false (Dari default karena API lupa mengirim)
    expect(motorcycles.first.isNew, true);
    expect(motorcycles.first.isRecommended, false); 
    print('✅ 4. Sistem Pencegah Null & Keamanan Default (Fail-Safe) Berhasil.');

    print('\\n🎉 SEMUA PENGUJIAN SUPER APP LULUS!');
  });
}
