// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) => _AppSettings(
  notifEnabled: json['notifEnabled'] as bool,
  biometricEnabled: json['biometricEnabled'] as bool,
  selectedLanguage: json['selectedLanguage'] as String,
);

Map<String, dynamic> _$AppSettingsToJson(_AppSettings instance) =>
    <String, dynamic>{
      'notifEnabled': instance.notifEnabled,
      'biometricEnabled': instance.biometricEnabled,
      'selectedLanguage': instance.selectedLanguage,
    };
