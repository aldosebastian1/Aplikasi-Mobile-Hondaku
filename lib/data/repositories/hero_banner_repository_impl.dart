import '../../domain/repositories/hero_banner_repository.dart';
import '../hero_banner_data.dart';

class HeroBannerRepositoryImpl implements HeroBannerRepository {
  @override
  Future<List<HeroBanner>> getHeroBanners() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return heroBannersDatabase;
  }
}
