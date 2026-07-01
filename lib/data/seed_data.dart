import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hondaku/data/motorcycle_data.dart';
import 'dart:developer' as developer;

Future<void> seedFirestoreDatabase() async {
  try {
    developer.log('Memulai proses upload data motor ke Firestore...');
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference motorcyclesRef = db.collection('motorcycles');
    
    // Upload each motorcycle to Firestore
    for (var motor in motorcycleDatabase) {
      // Use the motorcycle ID as the document ID
      await motorcyclesRef.doc(motor.id).set(motor.toJson());
    }
    
    developer.log('✅ Berhasil upload ${motorcycleDatabase.length} motor ke Firestore!');
  } catch (e) {
    developer.log('❌ Gagal upload: $e');
    throw Exception('Gagal upload data: $e');
  }
}
