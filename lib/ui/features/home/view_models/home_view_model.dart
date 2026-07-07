import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/providers.dart';
import '../../../../domain/models/hero_banner.dart';

final homeMotorcyclesProvider = motorcyclesProvider;

final homeBannersProvider = FutureProvider.autoDispose<List<HeroBanner>>((ref) async {
  // Hanya perlu melakukan fetch dari satu sumber saja secara langsung
  final repository = ref.watch(heroBannerRepositoryProvider);
  final banners = await repository.getHeroBanners();
  return banners;
});
