// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Review _$ReviewFromJson(Map<String, dynamic> json) => _Review(
  id: json['id'] as String,
  userId: json['userId'] as String,
  pesananId: json['pesananId'] as String,
  motorId: json['motorId'] as String,
  namaMotor: json['namaMotor'] as String,
  rating: (json['rating'] as num).toInt(),
  komentar: json['komentar'] as String,
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp,
  ),
);

Map<String, dynamic> _$ReviewToJson(_Review instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'pesananId': instance.pesananId,
  'motorId': instance.motorId,
  'namaMotor': instance.namaMotor,
  'rating': instance.rating,
  'komentar': instance.komentar,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
};
