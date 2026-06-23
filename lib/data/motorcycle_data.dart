import 'package:flutter/material.dart';
import '../domain/models/motorcycle.dart';
export '../domain/models/motorcycle.dart';



// Pusat Data Base List Mockup
final List<Motorcycle> motorcycleDatabase = [
  const Motorcycle(
    id: '1',
    name: "BeAT",
    categoryBadge: "MATIC",
    subtitle: "Matic • 110cc",
    description: "Compact and agile, perfect for your daily urban commute.",
    price: "Rp 19.155.000",
    imageAsset: "assets/images/Beat 1.png",
    isRecommended: true,
    engine: "109,5 cc",
    maxPower: "6,6 kW",
    fuelCapacity: "4,2 L",
    features: [
      MotorcycleFeature(
        icon: Icons.electric_bolt_outlined,
        title: 'eSP Engine',
        description:
            'Mesin eSP generasi terbaru yang lebih efisien dan bertenaga.',
      ),
      MotorcycleFeature(
        icon: Icons.security_outlined,
        title: 'Secure Key Shutter',
        description: 'Sistem penguncian bermagnet untuk keamanan maksimal.',
      ),
    ],
    specsMesin: {
      'Tipe': '4-Langkah, SOHC, eSP',
      'Kapasitas': '109,5 cc',
      'Daya Maksimal': '6,6 kW (9,0 PS) / 7.500 rpm',
      'Torsi Maksimal': '9,2 Nm (0,94 kgf.m) / 6.000 rpm',
      'Sistem Suplai': 'PGM-FI',
    },
    specsRangka: {
      'Tipe Rangka': 'Tulang punggung - eSAF',
      'Tipe Ban Depan': '80/90 - 14M/C 40P (Tubeless)',
      'Tipe Ban Belakang': '90/90 - 14M/C 40P (Tubeless)',
      'Sistem Pengereman': 'COMBI BRAKE SYSTEM',
    },
    specsDimensi: {
      'Panjang x Lebar x Tinggi': '1876 X 669 X 1080 mm',
      'Jarak Sumbu Roda': '1.255 mm',
      'Berat Kosong': '88 kg',
      'Kapasitas Tangki Bensin': '4,2 Liter',
    },
  ),
  const Motorcycle(
    id: '2',
    name: "BeAT Street",
    categoryBadge: "MATIC",
    subtitle: "Matic • 110cc",
    description:
        "Tampil tangguh dengan gaya urban street. Naked handlebar dan panel meter full digital yang modern.",
    price: "Rp 20.026.000",
    imageAsset: "assets/images/Beat 1.png",
    engine: "109,5 cc",
    maxPower: "6,6 kW",
    fuelCapacity: "4,2 L",
    features: [
      MotorcycleFeature(
        icon: Icons.settings_input_component_outlined,
        title: 'Naked Handlebar',
        description: 'Stang terbuka untuk kontrol maksimal di jalanan kota.',
      ),
      MotorcycleFeature(
        icon: Icons.speed_outlined,
        title: 'Full Digital Panel Meter',
        description:
            'Indikator modern yang mempermudah pemantauan status kendaraan.',
      ),
    ],
    specsMesin: {
      'Tipe': '4-Langkah, SOHC, eSP',
      'Kapasitas': '109,5 cc',
      'Daya Maksimal': '6,6 kW (9,0 PS) / 7.500 rpm',
      'Torsi Maksimal': '9,2 Nm (0,94 kgf.m) / 6.000 rpm',
      'Sistem Suplai': 'PGM-FI',
    },
    specsRangka: {
      'Tipe Rangka': 'Tulang punggung - eSAF',
      'Tipe Ban Depan': '80/90 - 14M/C 40P (Tubeless)',
      'Tipe Ban Belakang': '90/90 - 14M/C 40P (Tubeless)',
      'Sistem Pengereman': 'Combi Brake System (CBS)',
    },
    specsDimensi: {
      'Panjang x Lebar x Tinggi': '1876 x 669 x 1080 mm',
      'Jarak Sumbu Roda': '1.255 mm',
      'Berat Kosong': '89 kg',
      'Kapasitas Tangki Bensin': '4,2 Liter',
    },
  ),
  const Motorcycle(
    id: '3',
    name: "Vario 125",
    categoryBadge: "MATIC",
    subtitle: "Matic • 125cc",
    description:
        "Kombinasi sempurna desain sporty dan fitur canggih untuk mobilitas harian yang lebih bertenaga.",
    price: "Rp 24.560.000",
    imageAsset: "assets/images/Beat 1.png",
    engine: "124,8 cc",
    maxPower: "8,2 kW",
    fuelCapacity: "5,5 L",
    features: [
      MotorcycleFeature(
        icon: Icons.vpn_key_outlined,
        title: 'Smart Key System',
        description: 'Keamanan ekstra dengan kunci pintar tanpa anak kunci.',
      ),
      MotorcycleFeature(
        icon: Icons.battery_charging_full_outlined,
        title: 'USB Power Charger',
        description: 'Tetap terhubung dengan pengisian daya gadget di console.',
      ),
    ],
    specsMesin: {
      'Tipe': '4-Langkah, SOHC, eSP, Pendingin Cairan',
      'Kapasitas': '124,8 cc',
      'Daya Maksimal': '8,2 kW (11,1 PS) / 8.500 rpm',
      'Torsi Maksimal': '10,8 Nm (1,1 kgf.m) / 5.000 rpm',
      'Sistem Suplai': 'Injeksi (PGM-FI)',
    },
    specsRangka: {
      'Tipe Rangka': 'Underbone',
      'Tipe Ban Depan': '90/80 - 14M/C 43P (Tubeless)',
      'Tipe Ban Belakang': '100/80 - 14M/C 48P (Tubeless)',
      'Sistem Pengereman': 'Wavy Disc Brake',
    },
    specsDimensi: {
      'Panjang x Lebar x Tinggi': '1.918 x 679 x 1.066 mm',
      'Jarak Sumbu Roda': '1.280 mm',
      'Berat Kosong': '111 kg',
      'Kapasitas Tangki Bensin': '5,5 Liter',
    },
  ),
  const Motorcycle(
    id: '4',
    name: "Vario 160",
    categoryBadge: "MATIC",
    subtitle: "Matic • 160cc",
    description:
        "Performa mesin eSP+ 160cc yang prestisius dengan desain bodi besar yang menawan dan futuristik.",
    price: "Rp 32.850.000",
    imageAsset: "assets/images/Beat 1.png",
    isNew: true,
    engine: "156,9 cc",
    maxPower: "11,3 kW",
    fuelCapacity: "5,5 L",
    features: [
      MotorcycleFeature(
        icon: Icons.shield_outlined,
        title: 'ABS System',
        description: 'Stabilitas pengereman maksimal untuk keamanan berkendara.',
      ),
      MotorcycleFeature(
        icon: Icons.light_mode_outlined,
        title: 'Full LED Lighting',
        description: 'Tampilan modern dan pencahayaan lebih terang di malam hari.',
      ),
    ],
    specsMesin: {
      'Tipe': '4-Langkah, 4-Katup, eSP+, Pendingin Cairan',
      'Kapasitas': '156,9 cc',
      'Daya Maksimal': '11,3 kW (15,4 PS) / 8.500 rpm',
      'Torsi Maksimal': '13,8 Nm (1,4 kgf.m) / 7.000 rpm',
      'Sistem Suplai': 'PGM-FI',
    },
    specsRangka: {
      'Tipe Rangka': 'Underbone - New eSAF Design',
      'Tipe Ban Depan': '100/80 - 14M/C (Tubeless)',
      'Tipe Ban Belakang': '120/70 - 14M/C (Tubeless)',
      'Sistem Pengereman': 'Double Disc Brake (ABS)',
    },
    specsDimensi: {
      'Panjang x Lebar x Tinggi': '1.929 x 679 x 1.088 mm',
      'Jarak Sumbu Roda': '1.277 mm',
      'Berat Kosong': '117 kg (Tipe ABS)',
      'Kapasitas Tangki Bensin': '5,5 Liter',
    },
  ),
  const Motorcycle(
    id: '5',
    name: "CBR250RR",
    categoryBadge: "SPORT",
    subtitle: "Sport • 250cc",
    description:
        "Wujudkan mimpi supersport Anda dengan kendali penuh. Performa mesin 2 silinder kelas dunia.",
    price: "Rp 64.500.000",
    imageAsset: "assets/images/Beat 1.png",
    engine: "249,7 cc",
    maxPower: "30 kW",
    fuelCapacity: "14,5 L",
    features: [
      MotorcycleFeature(
        icon: Icons.bolt_outlined,
        title: 'Quick Shifter',
        description: 'Akselerasi mulus tanpa hambatan saat perpindahan gigi.',
      ),
      MotorcycleFeature(
        icon: Icons.touch_app_outlined,
        title: 'Throttle by Wire',
        description: 'Akurasi gas maksimal dengan 3 pilihan riding mode.',
      ),
    ],
    specsMesin: {
      'Tipe': '4-Langkah, 8-Katup, Parallel Twin Cylinder',
      'Kapasitas': '249,7 cc',
      'Daya Maksimal': '30 kW (40,8 PS) / 13.000 rpm',
      'Torsi Maksimal': '25 Nm (2,5 kgf.m) / 11.000 rpm',
      'Sistem Suplai': 'PGM-FI',
    },
    specsRangka: {
      'Tipe Rangka': 'Diamond (Truss) Frame',
      'Tipe Ban Depan': '110/70-17 54S (Tubeless)',
      'Tipe Ban Belakang': '140/70-17 66S (Tubeless)',
      'Sistem Pengereman': 'Dual Disc Brake with ABS',
    },
    specsDimensi: {
      'Panjang x Lebar x Tinggi': '2.060 x 724 x 1.098 mm',
      'Jarak Sumbu Roda': '1.389 mm',
      'Berat Kosong': '168 kg',
      'Kapasitas Tangki Bensin': '14,5 Liter',
    },
  ),
  const Motorcycle(
    id: '6',
    name: "CB500X",
    categoryBadge: "ADVENTURE",
    subtitle: "Adventure • 500cc",
    description:
        "Jelajahi setiap rintangan tanpa batas. Motor adventure yang dirancang untuk kenyamanan touring jauh.",
    price: "Rp 194.500.000",
    imageAsset: "assets/images/Beat 1.png",
    engine: "471 cc",
    maxPower: "37 kW",
    fuelCapacity: "17,7 L",
    features: [
      MotorcycleFeature(
        icon: Icons.landscape_outlined,
        title: 'Touring Ergonomics',
        description: 'Posisi berkendara tegak yang nyaman untuk perjalanan jauh.',
      ),
      MotorcycleFeature(
        icon: Icons.settings_input_hdmi_outlined,
        title: 'Adjustable Windscreen',
        description: 'Pelindung angin yang dapat diatur sesuai kebutuhan.',
      ),
    ],
    specsMesin: {
      'Tipe': 'Liquid-Cooled, 4-Stroke DOHC Parallel Twin',
      'Kapasitas': '471 cc',
      'Daya Maksimal': '37 kW / 8.500 rpm',
      'Torsi Maksimal': '45 Nm / 6.500 rpm',
      'Sistem Suplai': 'PGM-FI',
    },
    specsRangka: {
      'Tipe Rangka': 'Steel Diamond Frame',
      'Tipe Ban Depan': '110/80R19M/C',
      'Tipe Ban Belakang': '160/60R17M/C',
      'Sistem Pengereman': 'ABS Dual Channel',
    },
    specsDimensi: {
      'Panjang x Lebar x Tinggi': '2.155 x 825 x 1.410 mm',
      'Jarak Sumbu Roda': '1.445 mm',
      'Berat Kosong': '197 kg',
      'Kapasitas Tangki Bensin': '17,7 Liter',
    },
  ),
];
