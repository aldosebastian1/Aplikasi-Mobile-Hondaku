import '../models/garage_item.dart';

abstract class GarageRepository {
  Future<List<GarageItem>> getGarageItems();
  Future<void> addVehicle(GarageItem item);
}
