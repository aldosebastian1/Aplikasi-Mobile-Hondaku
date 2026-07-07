import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/garage_item.dart';
import '../../domain/repositories/garage_repository.dart';

class GarageRepositoryImpl implements GarageRepository {
  final FirebaseFirestore _firestore;
  final String? uid;
  final StreamController<List<GarageItem>> _controller = StreamController<List<GarageItem>>.broadcast();
  StreamSubscription? _firestoreSub;

  GarageRepositoryImpl({this.uid, FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance {
    _initStream();
  }

  Future<void> _initStream() async {
    // Hanya mendengarkan pembaruan dari Firestore jika user login
    if (uid != null && uid!.isNotEmpty) {
      _firestoreSub = _firestore
          .collection('users')
          .doc(uid)
          .collection('garage')
          .snapshots()
          .listen((snapshot) {
        final remoteItems = snapshot.docs.map((doc) => GarageItem.fromJson(doc.data())).toList();
        _controller.add(remoteItems);
      });
    } else {
      // Jika tidak login, kembalikan list kosong
      _controller.add([]);
    }
  }

  @override
  Stream<List<GarageItem>> watchGarageItems() {
    return _controller.stream;
  }

  @override
  Future<void> addVehicle(GarageItem item) async {
    // Simpan ke Firebase saja
    if (uid != null && uid!.isNotEmpty) {
      try {
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('garage')
            .doc(item.id)
            .set(item.toJson());
      } catch (e) {
        throw Exception('Gagal menyimpan data kendaraan. Silakan periksa koneksi internet Anda.');
      }
    } else {
      throw Exception('Anda harus login untuk menyimpan kendaraan.');
    }
  }

  void dispose() {
    _firestoreSub?.cancel();
    _controller.close();
  }
}
