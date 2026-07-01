import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/repositories/motorcycle_repository.dart';
import '../domain/repositories/bank_repository.dart';
import '../domain/repositories/garage_repository.dart';
import '../domain/repositories/hero_banner_repository.dart';
import '../domain/repositories/aktivitas_repository.dart';
import '../domain/repositories/user_repository.dart';
import '../domain/models/motorcycle.dart';
import '../domain/models/bank_option.dart';
import '../domain/models/hero_banner.dart';
import 'repositories/motorcycle_repository_impl.dart';
import 'repositories/bank_repository_impl.dart';
import 'repositories/garage_repository_impl.dart';
import 'repositories/hero_banner_repository_impl.dart';
import 'repositories/aktivitas_repository_impl.dart';
import 'repositories/user_repository_impl.dart';

final motorcycleRepositoryProvider = Provider<MotorcycleRepository>((ref) {
  return MotorcycleRepositoryImpl();
});

final bankRepositoryProvider = Provider<BankRepository>((ref) {
  return BankRepositoryImpl();
});

final garageRepositoryProvider = Provider<GarageRepository>((ref) {
  return GarageRepositoryImpl();
});

final heroBannerRepositoryProvider = Provider<HeroBannerRepository>((ref) {
  return HeroBannerRepositoryImpl();
});

final aktivitasRepositoryProvider = Provider<AktivitasRepository>((ref) {
  return AktivitasRepositoryImpl();
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl();
});

// Future Providers for reactive UI consumption
final motorcyclesProvider = FutureProvider<List<Motorcycle>>((ref) async {
  final repository = ref.watch(motorcycleRepositoryProvider);
  return repository.getMotorcycles();
});

final heroBannersProvider = FutureProvider<List<HeroBanner>>((ref) async {
  final repository = ref.watch(heroBannerRepositoryProvider);
  return repository.getHeroBanners();
});

final bankOptionsProvider = FutureProvider<List<BankOption>>((ref) async {
  final repository = ref.watch(bankRepositoryProvider);
  return repository.getBankOptions();
});

