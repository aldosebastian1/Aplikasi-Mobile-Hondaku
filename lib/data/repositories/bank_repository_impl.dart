import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/bank_option.dart';
import '../../domain/repositories/bank_repository.dart';

class BankRepositoryImpl implements BankRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<BankOption>> getBankOptions() async {
    try {
      final snapshot = await _firestore.collection('banks').get();
      return snapshot.docs.map((doc) {
        return BankOption.fromJson(doc.data());
      }).toList();
    } catch (e) {
      throw Exception('Gagal mengambil daftar bank. Pastikan koneksi internet Anda stabil.');
    }
  }
}
