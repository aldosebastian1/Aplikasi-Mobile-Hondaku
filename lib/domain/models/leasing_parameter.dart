import 'package:freezed_annotation/freezed_annotation.dart';

part 'leasing_parameter.freezed.dart';
part 'leasing_parameter.g.dart';

@freezed
abstract class LeasingParameter with _$LeasingParameter {
  const factory LeasingParameter({
    required String id,
    required String name,
    required String subtitle,
    required double rateTahunan,
    required double minDpPersen,
    required double maxDpPersen,
    required List<int> tenorList,
  }) = _LeasingParameter;

  factory LeasingParameter.fromJson(Map<String, dynamic> json) =>
      _$LeasingParameterFromJson(json);
}
