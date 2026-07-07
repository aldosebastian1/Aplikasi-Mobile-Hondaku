import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/leasing_parameter.dart';
import '../../domain/repositories/leasing_repository.dart';

class LeasingRepositoryImpl implements LeasingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<LeasingParameter>> getLeasingParameters() async {
    try {
      final snapshot = await _firestore.collection('leasing_parameters').get();
      return snapshot.docs.map((doc) {
        return LeasingParameter.fromJson(doc.data());
      }).toList();
    } catch (e) {
      throw Exception('Gagal mengambil parameter leasing. Pastikan koneksi internet Anda stabil.');
    }
  }
}
