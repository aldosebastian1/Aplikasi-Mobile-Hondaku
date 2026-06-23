import '../models/hero_banner.dart';

abstract class HeroBannerRepository {
  Future<List<HeroBanner>> getHeroBanners();
}
