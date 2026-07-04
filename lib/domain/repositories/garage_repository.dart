import '../models/garage_item.dart';

abstract class GarageRepository {
  Stream<List<GarageItem>> watchGarageItems();
  Future<void> addVehicle(GarageItem item);
}
