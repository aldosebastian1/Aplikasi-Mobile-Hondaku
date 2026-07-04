// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garage_item.dart';

// JsonSerializableGenerator

_GarageItem _$GarageItemFromJson(Map<String, dynamic> json) => _GarageItem(
  id: json['id'] as String,
  name: json['name'] as String,
  type: json['type'] as String,
  imagePath: json['imagePath'] as String,
  category: json['category'] as String,
);

Map<String, dynamic> _$GarageItemToJson(_GarageItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'imagePath': instance.imagePath,
      'category': instance.category,
    };
