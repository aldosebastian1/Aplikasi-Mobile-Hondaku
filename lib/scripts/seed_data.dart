import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hondaku/scripts/mock_data/master_motorcycle_data.dart';
import 'package:hondaku/scripts/mock_data/master_bank_data.dart';
import 'package:hondaku/scripts/mock_data/master_home_slider_data.dart';
import 'package:hondaku/scripts/mock_data/master_leasing_data.dart';
import 'package:hondaku/scripts/mock_data/master_location_data.dart';
import 'dart:developer' as developer;

Future<void> seedFirestoreDatabase() async {
  try {
    developer.log('Memulai proses migrasi data otomatis ke Firestore...');
    final FirebaseFirestore db = FirebaseFirestore.instance;
    
    // Menggunakan WriteBatch untuk efisiensi dan keamanan transaksi (atomic)
    final WriteBatch batch = db.batch();
    
    // 1. Migrasi Motor
    final CollectionReference motorcyclesRef = db.collection('motorcycles');
    for (var motor in motorcycleDatabase) {
      batch.set(motorcyclesRef.doc(motor.id), motor.toJson());
    }
    developer.log('Menyiapkan ${motorcycleDatabase.length} motor...');

    // 2. Migrasi Bank
    final CollectionReference banksRef = db.collection('banks');
    for (var bank in bankOptions) {
      batch.set(banksRef.doc(bank.id), bank.toJson());
    }
    developer.log('Menyiapkan ${bankOptions.length} bank...');

    // 3. Migrasi Slider Sentral (Promo & Berita)
    final CollectionReference bannersRef = db.collection('hero_banners');
    int bannerIndex = 1;
    for (var banner in homeSliderDatabase) {
      batch.set(bannersRef.doc(bannerIndex.toString()), banner.toJson());
      bannerIndex++;
    }
    developer.log('Menyiapkan ${homeSliderDatabase.length} item slider...');

    // 4. Migrasi Leasing (Simulasi Kredit)
    final CollectionReference leasingRef = db.collection('leasing_parameters');
    for (var leasing in leasingOptions) {
      batch.set(leasingRef.doc(leasing.id), leasing.toJson());
    }
    developer.log('Menyiapkan ${leasingOptions.length} opsi leasing...');

    // 5. Migrasi Wilayah (Kecamatan & Kelurahan)
    final CollectionReference locationsRef = db.collection('locations');
    for (var location in locationDatabase) {
      batch.set(locationsRef.doc(location.id), location.toJson());
    }
    developer.log('Menyiapkan ${locationDatabase.length} wilayah kecamatan...');

    // Eksekusi semua perintah sekaligus
    await batch.commit();
    developer.log('🎉 Migrasi batch otomatis selesai dengan sukses!');
    
  } catch (e) {
    developer.log('❌ Gagal upload: $e');
    throw Exception('Gagal migrasi otomatis ke server. Pastikan koneksi dan aturan database sudah benar.');
  }
}
