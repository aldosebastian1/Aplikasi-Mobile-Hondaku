import '../models/kecamatan.dart';

abstract class LocationRepository {
  Future<List<Kecamatan>> getKecamatans();
}
