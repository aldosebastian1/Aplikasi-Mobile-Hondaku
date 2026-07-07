// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kecamatan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Kecamatan _$KecamatanFromJson(Map<String, dynamic> json) => _Kecamatan(
  id: json['id'] as String,
  name: json['name'] as String,
  kelurahan: (json['kelurahan'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$KecamatanToJson(_Kecamatan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'kelurahan': instance.kelurahan,
    };
