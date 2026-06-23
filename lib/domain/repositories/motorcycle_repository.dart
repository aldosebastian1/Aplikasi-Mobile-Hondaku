import '../models/motorcycle.dart';

abstract class MotorcycleRepository {
  Future<List<Motorcycle>> getMotorcycles();
  Future<Motorcycle?> getMotorcycleById(String id);
}
