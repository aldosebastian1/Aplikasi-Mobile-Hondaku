// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  nama: json['nama'] as String? ?? 'Pengguna Hondaku',
  username: json['username'] as String? ?? '',
  email: json['email'] as String? ?? '',
  phone: json['phone'] as String? ?? '-',
  nik: json['nik'] as String? ?? '-',
  avatarPath: json['avatarPath'] as String? ?? 'assets/images/profile.png',
  isCustomAvatar: json['isCustomAvatar'] as bool? ?? true,
  avatarBgColor: const ColorConverter().fromJson(
    (json['avatarBgColor'] as num).toInt(),
  ),
  initials: json['initials'] as String,
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'nama': instance.nama,
      'username': instance.username,
      'email': instance.email,
      'phone': instance.phone,
      'nik': instance.nik,
      'avatarPath': instance.avatarPath,
      'isCustomAvatar': instance.isCustomAvatar,
      'avatarBgColor': const ColorConverter().toJson(instance.avatarBgColor),
      'initials': instance.initials,
    };
