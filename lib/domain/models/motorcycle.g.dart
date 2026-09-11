// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'motorcycle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MotorcycleFeature _$MotorcycleFeatureFromJson(Map<String, dynamic> json) =>
    _MotorcycleFeature(
      iconName: json['icon_name'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$MotorcycleFeatureToJson(_MotorcycleFeature instance) =>
    <String, dynamic>{
      'icon_name': instance.iconName,
      'title': instance.title,
      'description': instance.description,
    };

_Motorcycle _$MotorcycleFromJson(Map<String, dynamic> json) => _Motorcycle(
  id: json['id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  categoryBadge: json['category_badge'] as String? ?? '',
  subtitle: json['subtitle'] as String? ?? '',
  description: json['description'] as String? ?? '',
  price: json['price'] as String? ?? '',
  imageAsset: json['image_asset'] as String? ?? '',
  isNew: json['is_new'] as bool? ?? false,
  isRecommended: json['is_recommended'] as bool? ?? false,
  engine: json['engine'] as String? ?? '',
  maxPower: json['max_power'] as String? ?? '',
  fuelCapacity: json['fuel_capacity'] as String? ?? '',
  features:
      (json['features'] as List<dynamic>?)
          ?.map((e) => MotorcycleFeature.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  specsMesin:
      (json['specs_mesin'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  specsRangka:
      (json['specs_rangka'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  specsDimensi:
      (json['specs_dimensi'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
);

Map<String, dynamic> _$MotorcycleToJson(_Motorcycle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category_badge': instance.categoryBadge,
      'subtitle': instance.subtitle,
      'description': instance.description,
      'price': instance.price,
      'image_asset': instance.imageAsset,
      'is_new': instance.isNew,
      'is_recommended': instance.isRecommended,
      'engine': instance.engine,
      'max_power': instance.maxPower,
      'fuel_capacity': instance.fuelCapacity,
      'features': instance.features.map((e) => e.toJson()).toList(),
      'specs_mesin': instance.specsMesin,
      'specs_rangka': instance.specsRangka,
      'specs_dimensi': instance.specsDimensi,
    };
