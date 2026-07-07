// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentMethodItem _$PaymentMethodItemFromJson(Map<String, dynamic> json) =>
    _PaymentMethodItem(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      logoPath: json['logoPath'] as String,
      isDefault: json['isDefault'] as bool? ?? false,
      type: json['type'] as String,
    );

Map<String, dynamic> _$PaymentMethodItemToJson(_PaymentMethodItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'logoPath': instance.logoPath,
      'isDefault': instance.isDefault,
      'type': instance.type,
    };
