import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/hero_banner.dart';
import '../../domain/repositories/hero_banner_repository.dart';

class HeroBannerRepositoryImpl implements HeroBannerRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<HeroBanner>> getHeroBanners() async {
    try {
      final snapshot = await _firestore.collection('hero_banners').get();
      return snapshot.docs.map((doc) {
        return HeroBanner.fromJson(doc.data());
      }).toList();
    } catch (e) {
      throw Exception('Gagal memuat promo terbaru. Silakan coba lagi.');
    }
  }
}
