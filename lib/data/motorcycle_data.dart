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
    description:
        "Motor matic Honda BeAT hadir dengan desain modern, ringan, irit bahan bakar, dan cocok untuk mobilitas harian di perkotaan.",
    price: "Rp 19.155.000",
    imageAsset: "assets/images/products/matic/beat.webp",
    isRecommended: true,
    engine: "109,5 cc",
    maxPower: "6,6 kW",
    fuelCapacity: "4,2 L",
    features: [
      MotorcycleFeature(
        icon: Icons.local_gas_station_outlined,
        title: "PGM-FI",
        description:
            "Teknologi injeksi yang membuat konsumsi bahan bakar lebih irit.",
      ),
      MotorcycleFeature(
        icon: Icons.electric_bolt_outlined,
        title: "eSP Engine",
        description:
            "Mesin Enhanced Smart Power yang bertenaga dan ramah lingkungan.",
      ),
      MotorcycleFeature(
        icon: Icons.security_outlined,
        title: "Secure Key Shutter",
        description:
            "Sistem pengaman bermagnet untuk mencegah pencurian kendaraan.",
      ),
    ],
    specsMesin: {
      'Tipe': '4-Langkah, SOHC, eSP',
      'Kapasitas': '109,5 cc',
      'Daya Maksimal': '6,6 kW (9,0 PS) / 7.500 rpm',
      'Torsi Maksimal': '9,2 Nm / 6.000 rpm',
      'Sistem Suplai': 'PGM-FI',
      'Starter': 'Electric & Kick Starter',
      'Pendingin': 'Air Cooled',
      'Transmisi': 'Otomatis V-Matic',
    },
    specsRangka: {
      'Tipe Rangka': 'eSAF',
      'Suspensi Depan': 'Teleskopik',
      'Suspensi Belakang': 'Lengan Ayun',
      'Ban Depan': '80/90 - 14 Tubeless',
      'Ban Belakang': '90/90 - 14 Tubeless',
      'Rem Depan': 'Cakram',
      'Rem Belakang': 'Tromol',
      'Sistem Pengereman': 'CBS',
    },
    specsDimensi: {
      'Panjang x Lebar x Tinggi': '1.876 x 669 x 1.080 mm',
      'Jarak Sumbu Roda': '1.255 mm',
      'Jarak Terendah': '148 mm',
      'Tinggi Jok': '740 mm',
      'Berat Kosong': '88 kg',
      'Kapasitas Tangki': '4,2 Liter',
    },
  ),
  const Motorcycle(
    id: '2',
    name: "BeAT Street",
    categoryBadge: "MATIC",
    subtitle: "Matic • 110cc",
    description:
        "Honda BeAT Street tampil lebih sporty dengan naked handlebar dan panel meter digital yang cocok untuk gaya hidup anak muda.",
    price: "Rp 20.026.000",
    imageAsset: "assets/images/products/matic/beatstreet.webp",
    engine: "109,5 cc",
    maxPower: "6,6 kW",
    fuelCapacity: "4,2 L",
    features: [
      MotorcycleFeature(
        icon: Icons.speed_outlined,
        title: "Digital Panel Meter",
        description:
            "Speedometer full digital yang modern dan informatif.",
      ),
      MotorcycleFeature(
        icon: Icons.settings_input_component_outlined,
        title: "Naked Handlebar",
        description:
            "Stang model terbuka memberikan posisi berkendara lebih nyaman.",
      ),
      MotorcycleFeature(
        icon: Icons.electric_bolt_outlined,
        title: "eSP Engine",
        description:
            "Mesin eSP yang bertenaga, irit, dan ramah lingkungan.",
      ),
    ],
    specsMesin: {
      'Tipe': '4-Langkah, SOHC, eSP',
      'Kapasitas': '109,5 cc',
      'Daya Maksimal': '6,6 kW (9,0 PS) / 7.500 rpm',
      'Torsi Maksimal': '9,2 Nm / 6.000 rpm',
      'Sistem Suplai': 'PGM-FI',
      'Starter': 'Electric & Kick Starter',
      'Pendingin': 'Air Cooled',
      'Transmisi': 'V-Matic',
    },
    specsRangka: {
      'Tipe Rangka': 'eSAF',
      'Suspensi Depan': 'Teleskopik',
      'Suspensi Belakang': 'Lengan Ayun',
      'Ban Depan': '80/90 - 14 Tubeless',
      'Ban Belakang': '90/90 - 14 Tubeless',
      'Rem Depan': 'Cakram',
      'Rem Belakang': 'Tromol',
      'Sistem Pengereman': 'CBS',
    },
    specsDimensi: {
      'Panjang x Lebar x Tinggi': '1.876 x 742 x 1.080 mm',
      'Jarak Sumbu Roda': '1.255 mm',
      'Jarak Terendah': '147 mm',
      'Tinggi Jok': '742 mm',
      'Berat Kosong': '89 kg',
      'Kapasitas Tangki': '4,2 Liter',
    },
  ),
  const Motorcycle(
    id: '3',
    name: "Genio",
    categoryBadge: "MATIC",
    subtitle: "Matic • 110cc",
    description:
        "Honda Genio hadir dengan desain fashionable, bodi compact, dan teknologi modern yang membuat perjalanan sehari-hari semakin nyaman dan hemat bahan bakar.",
    price: "Rp 20.325.000",
    imageAsset: "assets/images/products/matic/genio.webp",
    engine: "109,5 cc",
    maxPower: "6,6 kW",
    fuelCapacity: "4,2 L",
    features: [
      MotorcycleFeature(
        icon: Icons.palette_outlined,
        title: "Fashionable Design",
        description:
            "Desain stylish dan modern yang cocok untuk anak muda.",
      ),
      MotorcycleFeature(
        icon: Icons.electric_bolt_outlined,
        title: "eSP Engine",
        description:
            "Mesin Enhanced Smart Power yang irit, bertenaga, dan ramah lingkungan.",
      ),
      MotorcycleFeature(
        icon: Icons.local_gas_station_outlined,
        title: "PGM-FI",
        description:
            "Teknologi injeksi modern untuk konsumsi bahan bakar yang lebih efisien.",
      ),
    ],
    specsMesin: {
      'Tipe': '4-Langkah, SOHC, eSP',
      'Kapasitas': '109,5 cc',
      'Daya Maksimal': '6,6 kW (9,0 PS) / 7.500 rpm',
      'Torsi Maksimal': '9,3 Nm / 5.500 rpm',
      'Sistem Suplai': 'PGM-FI',
      'Starter': 'Electric & Kick Starter',
      'Pendingin': 'Air Cooled',
      'Transmisi': 'Otomatis V-Matic',
    },
    specsRangka: {
      'Tipe Rangka': 'eSAF',
      'Suspensi Depan': 'Teleskopik',
      'Suspensi Belakang': 'Lengan Ayun',
      'Ban Depan': '100/90 - 12 Tubeless',
      'Ban Belakang': '110/90 - 10 Tubeless',
      'Rem Depan': 'Cakram',
      'Rem Belakang': 'Tromol',
      'Sistem Pengereman': 'CBS',
    },
    specsDimensi: {
      'Panjang x Lebar x Tinggi': '1.869 x 692 x 1.061 mm',
      'Jarak Sumbu Roda': '1.251 mm',
      'Jarak Terendah': '147 mm',
      'Tinggi Jok': '740 mm',
      'Berat Kosong': '92 kg',
      'Kapasitas Tangki': '4,2 Liter',
    },
  ),
  const Motorcycle(
    id: '4',
    name: "Scoopy",
    categoryBadge: "MATIC",
    subtitle: "Matic • 110cc",
    description:
        "Honda Scoopy hadir dengan desain retro modern yang ikonik, dilengkapi fitur canggih dan kenyamanan berkendara untuk aktivitas sehari-hari.",
    price: "Rp 22.990.000",
    imageAsset: "assets/images/products/matic/scopy.webp",
    engine: "109,5 cc",
    maxPower: "6,6 kW",
    fuelCapacity: "4,2 L",
    features: [
      MotorcycleFeature(
        icon: Icons.vpn_key_outlined,
        title: "Smart Key System",
        description:
            "Sistem kunci pintar tanpa anak kunci yang lebih aman dan praktis.",
      ),
      MotorcycleFeature(
        icon: Icons.lightbulb_outline,
        title: "Full LED Lighting",
        description:
            "Lampu depan dan belakang LED yang terang dan hemat energi.",
      ),
      MotorcycleFeature(
        icon: Icons.phone_android_outlined,
        title: "USB Charger",
        description:
            "Memudahkan pengisian daya smartphone selama perjalanan.",
      ),
    ],
    specsMesin: {
      'Tipe': '4-Langkah, SOHC, eSP',
      'Kapasitas': '109,5 cc',
      'Daya Maksimal': '6,6 kW (9,0 PS) / 7.500 rpm',
      'Torsi Maksimal': '9,3 Nm / 5.500 rpm',
      'Sistem Suplai': 'PGM-FI',
      'Starter': 'Electric & Kick Starter',
      'Pendingin': 'Air Cooled',
      'Transmisi': 'V-Matic',
    },
    specsRangka: {
      'Tipe Rangka': 'eSAF',
      'Suspensi Depan': 'Teleskopik',
      'Suspensi Belakang': 'Lengan Ayun',
      'Ban Depan': '100/90 - 12 Tubeless',
      'Ban Belakang': '110/90 - 12 Tubeless',
      'Rem Depan': 'Cakram',
      'Rem Belakang': 'Tromol',
      'Sistem Pengereman': 'CBS',
    },
    specsDimensi: {
      'Panjang x Lebar x Tinggi': '1.869 x 693 x 1.075 mm',
      'Jarak Sumbu Roda': '1.251 mm',
      'Jarak Terendah': '145 mm',
      'Tinggi Jok': '746 mm',
      'Berat Kosong': '95 kg',
      'Kapasitas Tangki': '4,2 Liter',
    },
  ),
  const Motorcycle(
    id: '5',
    name: "Vario 125",
    categoryBadge: "MATIC",
    subtitle: "Matic • 125cc",
    description:
        "Honda Vario 125 menawarkan performa bertenaga, desain sporty modern, dan fitur lengkap untuk menunjang mobilitas harian yang nyaman.",
    price: "Rp 24.550.000",
    imageAsset: "assets/images/products/matic/vario125.webp",
    engine: "124,8 cc",
    maxPower: "8,2 kW",
    fuelCapacity: "5,5 L",
    features: [
      MotorcycleFeature(
        icon: Icons.vpn_key_outlined,
        title: "Smart Key System",
        description:
            "Sistem kunci pintar yang praktis dan meningkatkan keamanan kendaraan.",
      ),
      MotorcycleFeature(
        icon: Icons.phone_android_outlined,
        title: "USB Charger",
        description:
            "Mengisi daya smartphone menjadi lebih mudah saat berkendara.",
      ),
      MotorcycleFeature(
        icon: Icons.lightbulb_outline,
        title: "Full LED Lighting",
        description:
            "Pencahayaan lebih terang dengan tampilan modern.",
      ),
    ],
    specsMesin: {
      'Tipe': '4-Langkah, SOHC, eSP, Pendingin Cairan',
      'Kapasitas': '124,8 cc',
      'Daya Maksimal': '8,2 kW (11,1 PS) / 8.500 rpm',
      'Torsi Maksimal': '10,8 Nm / 5.000 rpm',
      'Sistem Suplai': 'PGM-FI',
      'Starter': 'Electric Starter',
      'Pendingin': 'Liquid Cooled',
      'Transmisi': 'V-Matic',
    },
    specsRangka: {
      'Tipe Rangka': 'Underbone',
      'Suspensi Depan': 'Teleskopik',
      'Suspensi Belakang': 'Swing Arm',
      'Ban Depan': '90/80 - 14 Tubeless',
      'Ban Belakang': '100/80 - 14 Tubeless',
      'Rem Depan': 'Cakram',
      'Rem Belakang': 'Tromol',
      'Sistem Pengereman': 'CBS',
    },
    specsDimensi: {
      'Panjang x Lebar x Tinggi': '1.918 x 679 x 1.066 mm',
      'Jarak Sumbu Roda': '1.280 mm',
      'Jarak Terendah': '131 mm',
      'Tinggi Jok': '769 mm',
      'Berat Kosong': '111 kg',
      'Kapasitas Tangki': '5,5 Liter',
    },
  ),
  const Motorcycle(
    id: '6',
    name: "Vario 125 Street",
    categoryBadge: "MATIC",
    subtitle: "Matic • 125cc",
    description:
        "Honda Vario 125 Street hadir dengan tampilan yang lebih sporty dan agresif, dipadukan dengan performa mesin 125cc yang responsif untuk aktivitas harian.",
    price: "Rp 25.100.000",
    imageAsset: "assets/images/products/matic/vario125street.webp",
    engine: "124,8 cc",
    maxPower: "8,2 kW",
    fuelCapacity: "5,5 L",
    features: [
      MotorcycleFeature(
        icon: Icons.speed_outlined,
        title: "Full Digital Panel",
        description:
            "Panel meter digital modern dengan informasi berkendara lengkap.",
      ),
      MotorcycleFeature(
        icon: Icons.vpn_key_outlined,
        title: "Smart Key System",
        description:
            "Sistem kunci pintar yang aman dan praktis tanpa anak kunci.",
      ),
      MotorcycleFeature(
        icon: Icons.phone_android_outlined,
        title: "USB Charger",
        description:
            "Mengisi daya smartphone lebih mudah selama perjalanan.",
      ),
    ],
    specsMesin: {
      'Tipe': '4-Langkah, SOHC, eSP, Pendingin Cairan',
      'Kapasitas': '124,8 cc',
      'Daya Maksimal': '8,2 kW (11,1 PS) / 8.500 rpm',
      'Torsi Maksimal': '10,8 Nm / 5.000 rpm',
      'Sistem Suplai': 'PGM-FI',
      'Starter': 'Electric Starter',
      'Pendingin': 'Liquid Cooled',
      'Transmisi': 'V-Matic',
    },
    specsRangka: {
      'Tipe Rangka': 'Underbone',
      'Suspensi Depan': 'Teleskopik',
      'Suspensi Belakang': 'Swing Arm',
      'Ban Depan': '90/80 - 14 Tubeless',
      'Ban Belakang': '100/80 - 14 Tubeless',
      'Rem Depan': 'Cakram',
      'Rem Belakang': 'Tromol',
      'Sistem Pengereman': 'CBS',
    },
    specsDimensi: {
      'Panjang x Lebar x Tinggi': '1.918 x 679 x 1.066 mm',
      'Jarak Sumbu Roda': '1.280 mm',
      'Jarak Terendah': '131 mm',
      'Tinggi Jok': '769 mm',
      'Berat Kosong': '112 kg',
      'Kapasitas Tangki': '5,5 Liter',
    },
  ),
  const Motorcycle(
    id: '7',
    name: "Vario 160",
    categoryBadge: "MATIC",
    subtitle: "Matic • 160cc",
    description:
        "Honda Vario 160 hadir dengan desain premium yang lebih besar, mesin eSP+ 160cc yang bertenaga, serta fitur modern untuk pengalaman berkendara yang lebih nyaman.",
    price: "Rp 32.850.000",
    imageAsset: "assets/images/products/matic/vario160.webp",
    isNew: true,
    engine: "156,9 cc",
    maxPower: "11,3 kW",
    fuelCapacity: "5,5 L",
    features: [
      MotorcycleFeature(
        icon: Icons.shield_outlined,
        title: "ABS System",
        description:
            "Sistem pengereman ABS memberikan keamanan lebih saat melakukan pengereman mendadak.",
      ),
      MotorcycleFeature(
        icon: Icons.light_mode_outlined,
        title: "Full LED Lighting",
        description:
            "Lampu LED modern dengan pencahayaan yang lebih terang.",
      ),
      MotorcycleFeature(
        icon: Icons.vpn_key_outlined,
        title: "Honda Smart Key",
        description:
            "Sistem smart key tanpa anak kunci yang lebih aman dan praktis.",
      ),
    ],
    specsMesin: {
      'Tipe': '4-Langkah, 4 Katup, eSP+, Pendingin Cairan',
      'Kapasitas': '156,9 cc',
      'Daya Maksimal': '11,3 kW (15,4 PS) / 8.500 rpm',
      'Torsi Maksimal': '13,8 Nm / 7.000 rpm',
      'Sistem Suplai': 'PGM-FI',
      'Starter': 'Electric Starter',
      'Pendingin': 'Liquid Cooled',
      'Transmisi': 'V-Matic',
    },
    specsRangka: {
      'Tipe Rangka': 'Enhanced Smart Architecture Frame (eSAF)',
      'Suspensi Depan': 'Teleskopik',
      'Suspensi Belakang': 'Swing Arm',
      'Ban Depan': '100/80 - 14 Tubeless',
      'Ban Belakang': '120/70 - 14 Tubeless',
      'Rem Depan': 'Cakram',
      'Rem Belakang': 'Cakram',
      'Sistem Pengereman': 'ABS',
    },
    specsDimensi: {
      'Panjang x Lebar x Tinggi': '1.929 x 679 x 1.088 mm',
      'Jarak Sumbu Roda': '1.277 mm',
      'Jarak Terendah': '140 mm',
      'Tinggi Jok': '778 mm',
      'Berat Kosong': '117 kg',
      'Kapasitas Tangki': '5,5 Liter',
    },
  ),
  const Motorcycle(
    id: '8',
    name: "Stylo 160",
    categoryBadge: "MATIC",
    subtitle: "Matic • 160cc",
    description:
        "Honda Stylo 160 memadukan desain retro premium dengan performa mesin 160cc eSP+ yang bertenaga. Cocok untuk pengendara yang mengutamakan gaya dan kenyamanan.",
    price: "Rp 30.425.000",
    imageAsset: "assets/images/products/matic/stylo.webp",
    engine: "156,9 cc",
    maxPower: "11,3 kW",
    fuelCapacity: "5,5 L",
    features: [
      MotorcycleFeature(
        icon: Icons.style_outlined,
        title: "Premium Retro Design",
        description:
            "Desain klasik modern dengan sentuhan premium yang elegan.",
      ),
      MotorcycleFeature(
        icon: Icons.vpn_key_outlined,
        title: "Honda Smart Key",
        description:
            "Sistem smart key tanpa anak kunci yang praktis dan aman.",
      ),
      MotorcycleFeature(
        icon: Icons.light_mode_outlined,
        title: "Full LED Lighting",
        description:
            "Lampu LED depan dan belakang dengan tampilan modern.",
      ),
    ],
    specsMesin: {
      'Tipe': '4-Langkah, 4 Katup, eSP+, Pendingin Cairan',
      'Kapasitas': '156,9 cc',
      'Daya Maksimal': '11,3 kW (15,4 PS) / 8.500 rpm',
      'Torsi Maksimal': '13,8 Nm / 7.000 rpm',
      'Sistem Suplai': 'PGM-FI',
      'Starter': 'Electric Starter',
      'Pendingin': 'Liquid Cooled',
      'Transmisi': 'V-Matic',
    },
    specsRangka: {
      'Tipe Rangka': 'eSAF',
      'Suspensi Depan': 'Teleskopik',
      'Suspensi Belakang': 'Swing Arm',
      'Ban Depan': '110/70 - 12 Tubeless',
      'Ban Belakang': '130/70 - 12 Tubeless',
      'Rem Depan': 'Disc Brake',
      'Rem Belakang': 'Disc Brake',
      'Sistem Pengereman': 'ABS',
    },
    specsDimensi: {
      'Panjang x Lebar x Tinggi': '1.886 x 706 x 1.133 mm',
      'Jarak Sumbu Roda': '1.275 mm',
      'Jarak Terendah': '151 mm',
      'Tinggi Jok': '768 mm',
      'Berat Kosong': '118 kg',
      'Kapasitas Tangki': '5,5 Liter',
    },
  ),
  const Motorcycle(
    id: '9',
    name: "PCX160",
    categoryBadge: "MATIC",
    subtitle: "Matic • 160cc",
    description:
        "Honda PCX160 menghadirkan kenyamanan premium dengan desain elegan, mesin eSP+ 160cc yang responsif, serta fitur modern untuk perjalanan harian maupun touring.",
    price: "Rp 33.750.000",
    imageAsset: "assets/images/products/matic/pcx.webp",
    engine: "156,9 cc",
    maxPower: "11,8 kW",
    fuelCapacity: "8,1 L",
    features: [
      MotorcycleFeature(
        icon: Icons.vpn_key_outlined,
        title: "Honda Smart Key",
        description:
            "Smart key system lengkap dengan alarm dan answer back system.",
      ),
      MotorcycleFeature(
        icon: Icons.phone_android_outlined,
        title: "USB Charger",
        description:
            "USB charger type-C untuk mengisi daya smartphone selama perjalanan.",
      ),
      MotorcycleFeature(
        icon: Icons.airline_seat_recline_normal_outlined,
        title: "Comfort Seat",
        description:
            "Jok lebar dan ergonomis memberikan kenyamanan maksimal.",
      ),
    ],
    specsMesin: {
      'Tipe': '4-Langkah, 4 Katup, eSP+, Pendingin Cairan',
      'Kapasitas': '156,9 cc',
      'Daya Maksimal': '11,8 kW (16 PS) / 8.500 rpm',
      'Torsi Maksimal': '14,7 Nm / 6.500 rpm',
      'Sistem Suplai': 'PGM-FI',
      'Starter': 'Electric Starter',
      'Pendingin': 'Liquid Cooled',
      'Transmisi': 'V-Matic',
    },
    specsRangka: {
      'Tipe Rangka': 'Double Cradle',
      'Suspensi Depan': 'Teleskopik',
      'Suspensi Belakang': 'Twin Subtank',
      'Ban Depan': '110/70 - 14 Tubeless',
      'Ban Belakang': '130/70 - 13 Tubeless',
      'Rem Depan': 'Disc Brake',
      'Rem Belakang': 'Disc Brake',
      'Sistem Pengereman': 'ABS',
    },
    specsDimensi: {
      'Panjang x Lebar x Tinggi': '1.936 x 742 x 1.108 mm',
      'Jarak Sumbu Roda': '1.313 mm',
      'Jarak Terendah': '135 mm',
      'Tinggi Jok': '764 mm',
      'Berat Kosong': '132 kg',
      'Kapasitas Tangki': '8,1 Liter',
    },
  ),
  const Motorcycle(
    id: '10',
    name: "ADV160",
    categoryBadge: "MATIC",
    subtitle: "Adventure • 160cc",
    description:
        "Honda ADV160 dirancang untuk pengendara yang menyukai petualangan. Menggabungkan performa mesin eSP+ 160cc, kenyamanan berkendara, dan desain SUV Touring yang tangguh.",
    price: "Rp 37.265.000",
    imageAsset: "assets/images/products/matic/adv160.webp",
    engine: "156,9 cc",
    maxPower: "11,8 kW",
    fuelCapacity: "8,1 L",
    features: [
      MotorcycleFeature(
        icon: Icons.landscape_outlined,
        title: "Adjustable Windscreen",
        description:
            "Windscreen dapat diatur sesuai kebutuhan untuk kenyamanan berkendara.",
      ),
      MotorcycleFeature(
        icon: Icons.shield_outlined,
        title: "ABS Brake System",
        description:
            "Pengereman lebih stabil dan aman pada berbagai kondisi jalan.",
      ),
      MotorcycleFeature(
        icon: Icons.vpn_key_outlined,
        title: "Honda Smart Key",
        description:
            "Smart key system lengkap dengan alarm dan answer back system.",
      ),
    ],
    specsMesin: {
      'Tipe': '4-Langkah, 4 Katup, eSP+, Pendingin Cairan',
      'Kapasitas': '156,9 cc',
      'Daya Maksimal': '11,8 kW (16 PS) / 8.500 rpm',
      'Torsi Maksimal': '14,7 Nm / 6.500 rpm',
      'Sistem Suplai': 'PGM-FI',
      'Starter': 'Electric Starter',
      'Pendingin': 'Liquid Cooled',
      'Transmisi': 'V-Matic',
    },
    specsRangka: {
      'Tipe Rangka': 'Underbone',
      'Suspensi Depan': 'Teleskopik',
      'Suspensi Belakang': 'Twin Subtank',
      'Ban Depan': '110/80 - 14 Tubeless',
      'Ban Belakang': '130/70 - 13 Tubeless',
      'Rem Depan': 'Disc Brake',
      'Rem Belakang': 'Disc Brake',
      'Sistem Pengereman': 'ABS',
    },
    specsDimensi: {
      'Panjang x Lebar x Tinggi': '1.950 x 763 x 1.196 mm',
      'Jarak Sumbu Roda': '1.324 mm',
      'Jarak Terendah': '165 mm',
      'Tinggi Jok': '780 mm',
      'Berat Kosong': '133 kg',
      'Kapasitas Tangki': '8,1 Liter',
    },
  ),
  const Motorcycle(
    id: '11',
    name: "Forza",
    categoryBadge: "MATIC",
    subtitle: "Premium Matic • 250cc",
    description:
        "Honda Forza merupakan skutik premium berkapasitas 250cc yang menghadirkan kenyamanan, kemewahan, dan performa tinggi untuk perjalanan jarak dekat maupun touring.",
    price: "Rp 90.515.000",
    imageAsset: "assets/images/products/matic/pcx.webp",
    engine: "249,5 cc",
    maxPower: "17,0 kW",
    fuelCapacity: "11,7 L",
    features: [
      MotorcycleFeature(
        icon: Icons.height_outlined,
        title: "Electric Windscreen",
        description:
            "Windscreen elektrik yang dapat diatur sesuai kenyamanan pengendara.",
      ),
      MotorcycleFeature(
        icon: Icons.vpn_key_outlined,
        title: "Honda Smart Key",
        description:
            "Smart Key System lengkap dengan alarm dan answer back system.",
      ),
      MotorcycleFeature(
        icon: Icons.work_outline,
        title: "Large Luggage Box",
        description:
            "Bagasi ekstra luas yang mampu menyimpan dua helm sekaligus.",
      ),
    ],
    specsMesin: {
      'Tipe': '4-Langkah, SOHC, eSP+, Pendingin Cairan',
      'Kapasitas': '249,5 cc',
      'Daya Maksimal': '17,0 kW (23,1 PS) / 7.750 rpm',
      'Torsi Maksimal': '24 Nm / 6.250 rpm',
      'Sistem Suplai': 'PGM-FI',
      'Starter': 'Electric Starter',
      'Pendingin': 'Liquid Cooled',
      'Transmisi': 'CVT',
    },
    specsRangka: {
      'Tipe Rangka': 'Underbone',
      'Suspensi Depan': 'Teleskopik',
      'Suspensi Belakang': 'Twin Shock',
      'Ban Depan': '120/70 - 15 Tubeless',
      'Ban Belakang': '140/70 - 14 Tubeless',
      'Rem Depan': 'Double Disc Brake',
      'Rem Belakang': 'Disc Brake',
      'Sistem Pengereman': 'ABS',
    },
    specsDimensi: {
      'Panjang x Lebar x Tinggi': '2.145 x 754 x 1.360 mm',
      'Jarak Sumbu Roda': '1.510 mm',
      'Jarak Terendah': '135 mm',
      'Tinggi Jok': '780 mm',
      'Berat Kosong': '184 kg',
      'Kapasitas Tangki': '11,7 Liter',
    },
  ),
  const Motorcycle(
    id: '12',
    name: "CB150R Streetfire",
    categoryBadge: "SPORT",
    subtitle: "Sport • 150cc",
    description:
        "Honda CB150R Streetfire hadir dengan desain naked sport yang agresif, performa mesin DOHC 150cc yang responsif, serta handling yang lincah untuk penggunaan harian maupun touring.",
    price: "Rp 32.115.000",
    imageAsset: "assets/images/products/sport/cb150rstreetfire.webp",
    engine: "149,16 cc",
    maxPower: "12,4 kW",
    fuelCapacity: "12 L",
    features: [
      MotorcycleFeature(
        icon: Icons.bolt_outlined,
        title: "DOHC Engine",
        description:
            "Mesin DOHC 150cc memberikan performa tinggi dan akselerasi responsif.",
      ),
      MotorcycleFeature(
        icon: Icons.light_mode_outlined,
        title: "Full LED Lighting",
        description:
            "Lampu depan dan belakang LED dengan desain modern.",
      ),
      MotorcycleFeature(
        icon: Icons.speed_outlined,
        title: "Digital Panel Meter",
        description:
            "Panel instrumen full digital yang informatif dan mudah dibaca.",
      ),
    ],
    specsMesin: {
      'Tipe': '4-Langkah, DOHC, 4 Katup',
      'Kapasitas': '149,16 cc',
      'Daya Maksimal': '12,4 kW (16,9 PS) / 9.000 rpm',
      'Torsi Maksimal': '13,8 Nm / 7.000 rpm',
      'Sistem Suplai': 'PGM-FI',
      'Starter': 'Electric Starter',
      'Pendingin': 'Liquid Cooled',
      'Transmisi': '6 Percepatan',
    },
    specsRangka: {
      'Tipe Rangka': 'Diamond Frame',
      'Suspensi Depan': 'Inverted Front Suspension',
      'Suspensi Belakang': 'Monoshock',
      'Ban Depan': '100/80 - 17 Tubeless',
      'Ban Belakang': '130/70 - 17 Tubeless',
      'Rem Depan': 'Disc Brake',
      'Rem Belakang': 'Disc Brake',
      'Sistem Pengereman': 'Hydraulic Disc',
    },
    specsDimensi: {
      'Panjang x Lebar x Tinggi': '2.024 x 796 x 1.083 mm',
      'Jarak Sumbu Roda': '1.293 mm',
      'Jarak Terendah': '169 mm',
      'Tinggi Jok': '797 mm',
      'Berat Kosong': '136 kg',
      'Kapasitas Tangki': '12 Liter',
    },
  ),
  const Motorcycle(
    id: '13',
    name: "CBR150R",
    categoryBadge: "SPORT",
    subtitle: "Sport • 150cc",
    description:
        "Honda CBR150R hadir dengan desain supersport yang agresif, performa mesin DOHC 150cc, serta fitur modern yang memberikan sensasi berkendara layaknya motor balap.",
    price: "Rp 38.570.000",
    imageAsset: "assets/images/products/sport/cbr150r.webp",
    engine: "149,16 cc",
    maxPower: "12,6 kW",
    fuelCapacity: "12 L",
    features: [
      MotorcycleFeature(
        icon: Icons.sports_motorsports_outlined,
        title: "Supersport Design",
        description:
            "Desain fairing aerodinamis bergaya motor balap Honda Racing.",
      ),
      MotorcycleFeature(
        icon: Icons.speed_outlined,
        title: "Assist & Slipper Clutch",
        description:
            "Perpindahan gigi lebih ringan dan mengurangi engine brake saat downshift.",
      ),
      MotorcycleFeature(
        icon: Icons.light_mode_outlined,
        title: "Full LED Lighting",
        description:
            "Sistem pencahayaan LED penuh yang modern dan terang.",
      ),
    ],
    specsMesin: {
      'Tipe': '4-Langkah, DOHC, 4 Katup',
      'Kapasitas': '149,16 cc',
      'Daya Maksimal': '12,6 kW (17,1 PS) / 9.000 rpm',
      'Torsi Maksimal': '14,4 Nm / 7.000 rpm',
      'Sistem Suplai': 'PGM-FI',
      'Starter': 'Electric Starter',
      'Pendingin': 'Liquid Cooled',
      'Transmisi': '6 Percepatan',
    },
    specsRangka: {
      'Tipe Rangka': 'Diamond Frame',
      'Suspensi Depan': 'Showa USD Front Fork',
      'Suspensi Belakang': 'Pro-Link Monoshock',
      'Ban Depan': '100/80 - 17 Tubeless',
      'Ban Belakang': '130/70 - 17 Tubeless',
      'Rem Depan': 'Hydraulic Disc',
      'Rem Belakang': 'Hydraulic Disc',
      'Sistem Pengereman': 'ABS',
    },
    specsDimensi: {
      'Panjang x Lebar x Tinggi': '1.983 x 700 x 1.090 mm',
      'Jarak Sumbu Roda': '1.310 mm',
      'Jarak Terendah': '160 mm',
      'Tinggi Jok': '782 mm',
      'Berat Kosong': '139 kg',
      'Kapasitas Tangki': '12 Liter',
    },
  ),
  const Motorcycle(
    id: '14',
    name: "Supra X 125",
    categoryBadge: "CUB",
    subtitle: "Cub • 125cc",
    description:
        "Honda Supra X 125 merupakan motor bebek legendaris dengan mesin irit, tangguh, dan nyaman digunakan untuk aktivitas harian maupun perjalanan jauh.",
    price: "Rp 20.950.000",
    imageAsset: "assets/images/products/cub/supra_x_125_fi.webp",
    engine: "124,89 cc",
    maxPower: "7,4 kW",
    fuelCapacity: "4,0 L",
    features: [
      MotorcycleFeature(
        icon: Icons.local_gas_station_outlined,
        title: "PGM-FI",
        description:
            "Teknologi injeksi Honda yang membuat konsumsi bahan bakar lebih hemat.",
      ),
      MotorcycleFeature(
        icon: Icons.build_outlined,
        title: "Reliable Engine",
        description:
            "Mesin tangguh dengan perawatan mudah dan umur pakai panjang.",
      ),
      MotorcycleFeature(
        icon: Icons.light_mode_outlined,
        title: "Modern Headlamp",
        description:
            "Lampu depan modern dengan pencahayaan yang optimal.",
      ),
    ],
    specsMesin: {
      'Tipe': '4-Langkah, SOHC',
      'Kapasitas': '124,89 cc',
      'Daya Maksimal': '7,4 kW (10,1 PS) / 8.000 rpm',
      'Torsi Maksimal': '9,3 Nm / 4.000 rpm',
      'Sistem Suplai': 'PGM-FI',
      'Starter': 'Electric & Kick Starter',
      'Pendingin': 'Air Cooled',
      'Transmisi': '4 Percepatan',
    },
    specsRangka: {
      'Tipe Rangka': 'Backbone',
      'Suspensi Depan': 'Teleskopik',
      'Suspensi Belakang': 'Lengan Ayun',
      'Ban Depan': '70/90 - 17 Tubeless',
      'Ban Belakang': '80/90 - 17 Tubeless',
      'Rem Depan': 'Disc Brake',
      'Rem Belakang': 'Drum Brake',
      'Sistem Pengereman': 'CBS',
    },
    specsDimensi: {
      'Panjang x Lebar x Tinggi': '1.918 x 709 x 1.101 mm',
      'Jarak Sumbu Roda': '1.235 mm',
      'Jarak Terendah': '136 mm',
      'Tinggi Jok': '767 mm',
      'Berat Kosong': '106 kg',
      'Kapasitas Tangki': '4,0 Liter',
    },
  ),
  const Motorcycle(
    id: '15',
    name: "Sonic 150R",
    categoryBadge: "CUB",
    subtitle: "Cub • 150cc",
    description:
        "Honda Sonic 150R hadir dengan desain super sport underbone yang ringan, lincah, dan didukung mesin DOHC 150cc untuk performa maksimal di jalanan.",
    price: "Rp 28.430.000",
    imageAsset: "assets/images/products/sport/sonic150r.webp",
    engine: "149,16 cc",
    maxPower: "11,8 kW",
    fuelCapacity: "4,0 L",
    features: [
      MotorcycleFeature(
        icon: Icons.sports_motorsports_outlined,
        title: "DOHC Engine",
        description:
            "Mesin DOHC 150cc memberikan akselerasi yang responsif dan bertenaga.",
      ),
      MotorcycleFeature(
        icon: Icons.speed_outlined,
        title: "Digital Panel Meter",
        description:
            "Panel instrumen digital dengan informasi berkendara yang lengkap.",
      ),
      MotorcycleFeature(
        icon: Icons.light_mode_outlined,
        title: "LED Headlight",
        description:
            "Lampu depan LED modern dengan pencahayaan lebih terang.",
      ),
    ],
    specsMesin: {
      'Tipe': '4-Langkah, DOHC, 4 Katup',
      'Kapasitas': '149,16 cc',
      'Daya Maksimal': '11,8 kW (16 PS) / 9.000 rpm',
      'Torsi Maksimal': '13,5 Nm / 6.500 rpm',
      'Sistem Suplai': 'PGM-FI',
      'Starter': 'Electric Starter',
      'Pendingin': 'Liquid Cooled',
      'Transmisi': '6 Percepatan',
    },
    specsRangka: {
      'Tipe Rangka': 'Twin Tube Steel Frame',
      'Suspensi Depan': 'Teleskopik',
      'Suspensi Belakang': 'Monoshock',
      'Ban Depan': '70/90 - 17 Tubeless',
      'Ban Belakang': '80/90 - 17 Tubeless',
      'Rem Depan': 'Disc Brake',
      'Rem Belakang': 'Disc Brake',
      'Sistem Pengereman': 'Hydraulic Disc',
    },
    specsDimensi: {
      'Panjang x Lebar x Tinggi': '1.941 x 669 x 977 mm',
      'Jarak Sumbu Roda': '1.275 mm',
      'Jarak Terendah': '140 mm',
      'Tinggi Jok': '762 mm',
      'Berat Kosong': '114 kg',
      'Kapasitas Tangki': '4,0 Liter',
    },
  ),
  const Motorcycle(
    id: '16',
    name: "CRF150L",
    categoryBadge: "OFF ROAD",
    subtitle: "Off Road • 150cc",
    description:
        "Honda CRF150L merupakan motor dual purpose yang dirancang untuk menghadapi berbagai medan. Cocok digunakan di jalan raya maupun jalur off-road dengan suspensi yang tangguh dan mesin bertenaga.",
    price: "Rp 37.705.000",
    imageAsset: "assets/images/products/sport/crf150l.webp",
    engine: "149,15 cc",
    maxPower: "9,51 kW",
    fuelCapacity: "7,2 L",
    features: [
      MotorcycleFeature(
        icon: Icons.terrain_outlined,
        title: "Long Travel Suspension",
        description:
            "Suspensi depan dan belakang dengan travel panjang untuk kenyamanan di medan ekstrem.",
      ),
      MotorcycleFeature(
        icon: Icons.landscape_outlined,
        title: "Dual Purpose Tire",
        description:
            "Ban dual purpose yang memberikan traksi maksimal di jalan maupun off-road.",
      ),
      MotorcycleFeature(
        icon: Icons.sports_motorsports_outlined,
        title: "Pro-Link Suspension",
        description:
            "Suspensi belakang Pro-Link memberikan kestabilan saat melintasi berbagai medan.",
      ),
    ],
    specsMesin: {
      'Tipe': '4-Langkah, SOHC, 2 Katup',
      'Kapasitas': '149,15 cc',
      'Daya Maksimal': '9,51 kW (12,91 PS) / 8.000 rpm',
      'Torsi Maksimal': '12,43 Nm / 6.500 rpm',
      'Sistem Suplai': 'PGM-FI',
      'Starter': 'Electric Starter',
      'Pendingin': 'Air Cooled',
      'Transmisi': '5 Percepatan',
    },
    specsRangka: {
      'Tipe Rangka': 'Semi Double Cradle',
      'Suspensi Depan': 'Inverted Front Fork',
      'Suspensi Belakang': 'Pro-Link Monoshock',
      'Ban Depan': '70/100 - 21',
      'Ban Belakang': '90/100 - 18',
      'Rem Depan': 'Hydraulic Disc',
      'Rem Belakang': 'Hydraulic Disc',
      'Sistem Pengereman': 'Disc Brake',
    },
    specsDimensi: {
      'Panjang x Lebar x Tinggi': '2.119 x 793 x 1.153 mm',
      'Jarak Sumbu Roda': '1.375 mm',
      'Jarak Terendah': '285 mm',
      'Tinggi Jok': '869 mm',
      'Berat Kosong': '122 kg',
      'Kapasitas Tangki': '7,2 Liter',
    },
  ),
  const Motorcycle(
    id: '17',
    name: "CRF250 Rally",
    categoryBadge: "OFF ROAD",
    subtitle: "Adventure • 250cc",
    description:
        "Honda CRF250 Rally dirancang untuk petualangan sejati. Dengan desain ala motor Rally Dakar, mesin 250cc DOHC, dan suspensi long travel, motor ini siap menghadapi berbagai medan perjalanan.",
    price: "Rp 96.539.000",
    imageAsset: "assets/images/products/sport/crf250rally.webp",
    engine: "249,6 cc",
    maxPower: "18,3 kW",
    fuelCapacity: "12,8 L",
    features: [
      MotorcycleFeature(
        icon: Icons.landscape_outlined,
        title: "Rally Design",
        description:
            "Desain khas motor rally dengan windshield tinggi dan bodi adventure.",
      ),
      MotorcycleFeature(
        icon: Icons.settings_input_component_outlined,
        title: "Long Travel Suspension",
        description:
            "Suspensi Showa depan dan belakang memberikan kenyamanan di berbagai medan.",
      ),
      MotorcycleFeature(
        icon: Icons.explore_outlined,
        title: "Adventure Ready",
        description:
            "Ground clearance tinggi dan posisi berkendara ergonomis untuk perjalanan jauh.",
      ),
    ],
    specsMesin: {
      'Tipe': '4-Langkah, DOHC, Single Cylinder',
      'Kapasitas': '249,6 cc',
      'Daya Maksimal': '18,3 kW (24,8 PS) / 9.000 rpm',
      'Torsi Maksimal': '23 Nm / 6.500 rpm',
      'Sistem Suplai': 'PGM-FI',
      'Starter': 'Electric Starter',
      'Pendingin': 'Liquid Cooled',
      'Transmisi': '6 Percepatan',
    },
    specsRangka: {
      'Tipe Rangka': 'Semi Double Cradle',
      'Suspensi Depan': 'Showa Inverted Front Fork',
      'Suspensi Belakang': 'Showa Pro-Link Monoshock',
      'Ban Depan': '80/100 - 21',
      'Ban Belakang': '120/80 - 18',
      'Rem Depan': 'Hydraulic Disc',
      'Rem Belakang': 'Hydraulic Disc',
      'Sistem Pengereman': 'ABS',
    },
    specsDimensi: {
      'Panjang x Lebar x Tinggi': '2.210 x 920 x 1.425 mm',
      'Jarak Sumbu Roda': '1.455 mm',
      'Jarak Terendah': '270 mm',
      'Tinggi Jok': '885 mm',
      'Berat Kosong': '152 kg',
      'Kapasitas Tangki': '12,8 Liter',
    },
  ),
];
