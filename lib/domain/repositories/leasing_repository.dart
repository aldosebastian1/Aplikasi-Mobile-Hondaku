import '../models/leasing_parameter.dart';

abstract class LeasingRepository {
  Future<List<LeasingParameter>> getLeasingParameters();
}
