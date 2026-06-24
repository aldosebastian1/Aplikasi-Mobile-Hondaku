import '../domain/models/garage_item.dart';
export '../domain/models/garage_item.dart';



class GarageStore {
  // Simulasi data kendaraan yang sudah dimiliki (terpisah dari data transaksi/aktivitas)
  static const GarageItem myVehicle = GarageItem(
    id: 'GRG-001',
    name: 'Beat Deluxe',
    type: 'Matte Blue',
    imagePath: 'assets/images/Beat 1.png',
    category: 'DAILY RIDE',
  );
}
