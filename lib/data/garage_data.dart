import 'package:flutter/foundation.dart';

class GarageItem {
  final String id;
  final String name;
  final String type;
  final String imagePath;
  final String category; // e.g., 'DAILY RIDE', 'SPORT', 'MATIC'

  const GarageItem({
    required this.id,
    required this.name,
    required this.type,
    required this.imagePath,
    required this.category,
  });
}

class GarageStore {
  // Simulasi data kendaraan yang sudah dimiliki (terpisah dari data transaksi/aktivitas)
  static final GarageItem? myVehicle = GarageItem(
    id: 'GRG-001',
    name: 'Beat Deluxe',
    type: 'Matte Blue',
    imagePath: 'assets/images/Beat 1.png',
    category: 'DAILY RIDE',
  );
}
