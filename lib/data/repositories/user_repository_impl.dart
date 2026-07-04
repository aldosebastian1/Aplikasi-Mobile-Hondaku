import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/user_profile.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore;

  UserRepositoryImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<UserProfile?> getUserProfile(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return UserProfile.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Gagal mengambil data profil dari server. Silakan coba lagi nanti.');
    }
  }

  @override
  Future<void> saveUserProfile(String uid, UserProfile profile) async {
    try {
      await _firestore.collection('users').doc(uid).set(
        profile.toJson(),
        SetOptions(merge: true),
      );
    } catch (e) {
      throw Exception('Gagal menyimpan data profil ke server. Pastikan koneksi internet stabil.');
    }
  }
}
