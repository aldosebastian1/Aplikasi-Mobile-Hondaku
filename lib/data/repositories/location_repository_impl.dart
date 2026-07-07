import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/kecamatan.dart';
import '../../domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Kecamatan>> getKecamatans() async {
    try {
      final snapshot = await _firestore.collection('locations').get();
      return snapshot.docs.map((doc) {
        return Kecamatan.fromJson(doc.data());
      }).toList();
    } catch (e) {
      throw Exception('Gagal mengambil data wilayah. Pastikan koneksi internet Anda stabil.');
    }
  }
}
