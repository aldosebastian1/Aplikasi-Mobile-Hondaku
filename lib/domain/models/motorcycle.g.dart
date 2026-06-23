// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'motorcycle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MotorcycleFeature _$MotorcycleFeatureFromJson(Map<String, dynamic> json) =>
    _MotorcycleFeature(
      title: json['title'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$MotorcycleFeatureToJson(_MotorcycleFeature instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
    };

_Motorcycle _$MotorcycleFromJson(Map<String, dynamic> json) => _Motorcycle(
  id: json['id'] as String,
  name: json['name'] as String,
  categoryBadge: json['categoryBadge'] as String,
  subtitle: json['subtitle'] as String,
  description: json['description'] as String,
  price: json['price'] as String,
  imageAsset: json['imageAsset'] as String,
  isNew: json['isNew'] as bool? ?? false,
  isRecommended: json['isRecommended'] as bool? ?? false,
  engine: json['engine'] as String,
  maxPower: json['maxPower'] as String,
  fuelCapacity: json['fuelCapacity'] as String,
  features: (json['features'] as List<dynamic>)
      .map((e) => MotorcycleFeature.fromJson(e as Map<String, dynamic>))
      .toList(),
  specsMesin: Map<String, String>.from(json['specsMesin'] as Map),
  specsRangka: Map<String, String>.from(json['specsRangka'] as Map),
  specsDimensi: Map<String, String>.from(json['specsDimensi'] as Map),
);

Map<String, dynamic> _$MotorcycleToJson(_Motorcycle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'categoryBadge': instance.categoryBadge,
      'subtitle': instance.subtitle,
      'description': instance.description,
      'price': instance.price,
      'imageAsset': instance.imageAsset,
      'isNew': instance.isNew,
      'isRecommended': instance.isRecommended,
      'engine': instance.engine,
      'maxPower': instance.maxPower,
      'fuelCapacity': instance.fuelCapacity,
      'features': instance.features,
      'specsMesin': instance.specsMesin,
      'specsRangka': instance.specsRangka,
      'specsDimensi': instance.specsDimensi,
    };
