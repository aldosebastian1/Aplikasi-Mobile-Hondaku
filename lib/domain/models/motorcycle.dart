import 'package:freezed_annotation/freezed_annotation.dart';

part 'motorcycle.freezed.dart';
part 'motorcycle.g.dart';

@freezed
abstract class MotorcycleFeature with _$MotorcycleFeature {
  // Standar Enterprise: API biasanya menggunakan snake_case, kita mapping otomatis
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory MotorcycleFeature({
    @Default('') String iconName,
    @Default('') String title,
    @Default('') String description,
  }) = _MotorcycleFeature;

  factory MotorcycleFeature.fromJson(Map<String, dynamic> json) =>
      _$MotorcycleFeatureFromJson(json);
}

@freezed
abstract class Motorcycle with _$Motorcycle {
  // Standar Enterprise: Mencegah Crash Parsing
  // 1. explicitToJson: true agar nested object ikut ter-serialize
  // 2. fieldRename: FieldRename.snake otomatis mengubah 'max_power' dari API menjadi 'maxPower' di Dart
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory Motorcycle({
    @Default('') String id,
    @Default('') String name,
    @Default('') String categoryBadge,
    @Default('') String subtitle,
    @Default('') String description,
    @Default('') String price,
    @Default('') String imageAsset,
    @Default(false) bool isNew,
    @Default(false) bool isRecommended,
    @Default('') String engine,
    @Default('') String maxPower,
    @Default('') String fuelCapacity,
    // Gunakan list/map kosong sebagai default jika API mengembalikan null
    @Default([]) List<MotorcycleFeature> features,
    @Default({}) Map<String, String> specsMesin,
    @Default({}) Map<String, String> specsRangka,
    @Default({}) Map<String, String> specsDimensi,
  }) = _Motorcycle;

  factory Motorcycle.fromJson(Map<String, dynamic> json) =>
      _$MotorcycleFromJson(json);
}
