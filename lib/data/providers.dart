import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/repositories/motorcycle_repository.dart';
import '../domain/repositories/bank_repository.dart';
import '../domain/repositories/garage_repository.dart';
import '../domain/repositories/hero_banner_repository.dart';
import '../domain/repositories/aktivitas_repository.dart';
import '../domain/repositories/user_repository.dart';
import '../domain/repositories/leasing_repository.dart';
import '../domain/repositories/location_repository.dart';
import '../domain/models/motorcycle.dart';
import '../domain/models/bank_option.dart';
import '../domain/models/hero_banner.dart';
import '../domain/models/garage_item.dart';
import '../domain/models/leasing_parameter.dart';
import '../domain/models/kecamatan.dart';
import 'repositories/motorcycle_repository_impl.dart';
import 'repositories/bank_repository_impl.dart';
import 'repositories/garage_repository_impl.dart';
import 'repositories/hero_banner_repository_impl.dart';
import 'repositories/aktivitas_repository_impl.dart';
import 'repositories/user_repository_impl.dart';
import 'repositories/leasing_repository_impl.dart';
import 'repositories/location_repository_impl.dart';
import '../ui/features/auth/providers/auth_provider.dart';

final motorcycleRepositoryProvider = Provider<MotorcycleRepository>((ref) {
  return MotorcycleRepositoryImpl();
});

final bankRepositoryProvider = Provider<BankRepository>((ref) {
  return BankRepositoryImpl();
});

final garageRepositoryProvider = Provider<GarageRepository>((ref) {
  final user = ref.watch(authStateProvider).value;
  final repo = GarageRepositoryImpl(uid: user?.uid);
  ref.onDispose(() {
    repo.dispose();
  });
  return repo;
});

final garageViewModelProvider = StreamProvider<List<GarageItem>>((ref) {
  final repo = ref.watch(garageRepositoryProvider);
  return repo.watchGarageItems();
});

final heroBannerRepositoryProvider = Provider<HeroBannerRepository>((ref) {
  return HeroBannerRepositoryImpl();
});

final aktivitasRepositoryProvider = Provider<AktivitasRepository>((ref) {
  final user = ref.watch(authStateProvider).value;
  final garageRepo = ref.watch(garageRepositoryProvider);
  final repo = AktivitasRepositoryImpl(uid: user?.uid, garageRepository: garageRepo);
  ref.onDispose(() => repo.dispose());
  return repo;
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

final leasingRepositoryProvider = Provider<LeasingRepository>((ref) {
  return LeasingRepositoryImpl();
});

final leasingParametersProvider = FutureProvider<List<LeasingParameter>>((ref) async {
  final repository = ref.watch(leasingRepositoryProvider);
  return repository.getLeasingParameters();
});

final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  return LocationRepositoryImpl();
});

final locationsProvider = FutureProvider<List<Kecamatan>>((ref) async {
  final repository = ref.watch(locationRepositoryProvider);
  return repository.getKecamatans();
});
