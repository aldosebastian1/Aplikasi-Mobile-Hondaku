import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/providers.dart';
import '../../../../domain/models/motorcycle.dart';
import '../../../../domain/models/hero_banner.dart';

final homeMotorcyclesProvider = FutureProvider<List<Motorcycle>>((ref) async {
  final repository = ref.watch(motorcycleRepositoryProvider);
  return repository.getMotorcycles();
});

final homeBannersProvider = FutureProvider<List<HeroBanner>>((ref) async {
  final repository = ref.watch(heroBannerRepositoryProvider);
  return repository.getHeroBanners();
});
