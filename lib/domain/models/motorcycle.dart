import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'motorcycle.freezed.dart';
part 'motorcycle.g.dart';

@freezed
abstract class MotorcycleFeature with _$MotorcycleFeature {
  const factory MotorcycleFeature({
    @JsonKey(includeFromJson: false, includeToJson: false) IconData? icon,
    required String title,
    required String description,
  }) = _MotorcycleFeature;

  factory MotorcycleFeature.fromJson(Map<String, dynamic> json) =>
      _$MotorcycleFeatureFromJson(json);
}

@freezed
abstract class Motorcycle with _$Motorcycle {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory Motorcycle({
    required String id,
    required String name,
    required String categoryBadge,
    required String subtitle,
    required String description,
    required String price,
    required String imageAsset,
    @Default(false) bool isNew,
    @Default(false) bool isRecommended,
    required String engine,
    required String maxPower,
    required String fuelCapacity,
    required List<MotorcycleFeature> features,
    required Map<String, String> specsMesin,
    required Map<String, String> specsRangka,
    required Map<String, String> specsDimensi,
  }) = _Motorcycle;

  factory Motorcycle.fromJson(Map<String, dynamic> json) =>
      _$MotorcycleFromJson(json);
}
