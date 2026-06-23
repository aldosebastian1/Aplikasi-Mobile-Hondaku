import '../../domain/models/motorcycle.dart';
import '../../domain/repositories/motorcycle_repository.dart';
import '../motorcycle_data.dart';

class MotorcycleRepositoryImpl implements MotorcycleRepository {
  @override
  Future<List<Motorcycle>> getMotorcycles() async {
    // Simulasi delay jaringan
    await Future.delayed(const Duration(milliseconds: 100));
    return motorcycleDatabase;
  }

  @override
  Future<Motorcycle?> getMotorcycleById(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    try {
      return motorcycleDatabase.firstWhere((element) => element.id == id);
    } catch (_) {
      return null;
    }
  }
}
