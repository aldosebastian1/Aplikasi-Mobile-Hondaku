import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/motorcycle.dart';
import '../../domain/repositories/motorcycle_repository.dart';

class MotorcycleRepositoryImpl implements MotorcycleRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Motorcycle>> getMotorcycles() async {
    try {
      final snapshot = await _firestore.collection('motorcycles').get();
      return snapshot.docs.map((doc) {
        final data = doc.data();
        // Pastikan model Motorcycle Anda support konversi dari JSON
        return Motorcycle.fromJson(data); 
      }).toList();
    } catch (e) {
      // Jika terjadi error (misalnya rules atau belum ada koneksi)
      throw Exception('Gagal memuat katalog motor. Pastikan koneksi internet Anda stabil.');
    }
  }

  @override
  Future<Motorcycle?> getMotorcycleById(String id) async {
    try {
      // Kita asumsi nama dokumen di firestore adalah ID motor
      final doc = await _firestore.collection('motorcycles').doc(id).get();
      if (doc.exists && doc.data() != null) {
        return Motorcycle.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Gagal memuat data motor. Silakan coba lagi.');
    }
  }
}
