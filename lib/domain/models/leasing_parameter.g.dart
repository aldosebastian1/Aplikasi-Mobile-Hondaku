// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leasing_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeasingParameter _$LeasingParameterFromJson(Map<String, dynamic> json) =>
    _LeasingParameter(
      id: json['id'] as String,
      name: json['name'] as String,
      subtitle: json['subtitle'] as String,
      rateTahunan: (json['rateTahunan'] as num).toDouble(),
      minDpPersen: (json['minDpPersen'] as num).toDouble(),
      maxDpPersen: (json['maxDpPersen'] as num).toDouble(),
      tenorList: (json['tenorList'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$LeasingParameterToJson(_LeasingParameter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'subtitle': instance.subtitle,
      'rateTahunan': instance.rateTahunan,
      'minDpPersen': instance.minDpPersen,
      'maxDpPersen': instance.maxDpPersen,
      'tenorList': instance.tenorList,
    };
