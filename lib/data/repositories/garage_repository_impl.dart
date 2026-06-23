import '../../domain/models/garage_item.dart';
import '../../domain/repositories/garage_repository.dart';

class GarageRepositoryImpl implements GarageRepository {
  final List<GarageItem> _items = [
    const GarageItem(
      id: 'GRG-001',
      name: 'Beat Deluxe',
      type: 'Matte Blue',
      imagePath: 'assets/images/Beat 1.png',
      category: 'DAILY RIDE',
    ),
  ];

  @override
  Future<List<GarageItem>> getGarageItems() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return List.unmodifiable(_items);
  }

  @override
  Future<void> addVehicle(GarageItem item) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _items.add(item);
  }
}
