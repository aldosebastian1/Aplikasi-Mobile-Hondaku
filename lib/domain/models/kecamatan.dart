import 'package:freezed_annotation/freezed_annotation.dart';

part 'kecamatan.freezed.dart';
part 'kecamatan.g.dart';

@freezed
abstract class Kecamatan with _$Kecamatan {
  const factory Kecamatan({
    required String id,
    required String name,
    required List<String> kelurahan,
  }) = _Kecamatan;

  factory Kecamatan.fromJson(Map<String, dynamic> json) =>
      _$KecamatanFromJson(json);
}
