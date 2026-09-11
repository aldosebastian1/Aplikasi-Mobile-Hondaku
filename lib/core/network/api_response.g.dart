// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaginationMeta _$PaginationMetaFromJson(Map<String, dynamic> json) =>
    _PaginationMeta(
      currentPage: (json['current_page'] as num?)?.toInt() ?? 1,
      lastPage: (json['last_page'] as num?)?.toInt() ?? 1,
      total: (json['total'] as num?)?.toInt() ?? 0,
      perPage: (json['per_page'] as num?)?.toInt() ?? 15,
    );

Map<String, dynamic> _$PaginationMetaToJson(_PaginationMeta instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'total': instance.total,
      'per_page': instance.perPage,
    };

_ApiResponse<T> _$ApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _ApiResponse<T>(
  status: json['status'] as bool? ?? false,
  message: json['message'] as String? ?? '',
  data: _$nullableGenericFromJson(json['data'], fromJsonT),
  meta: json['meta'] == null
      ? null
      : PaginationMeta.fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ApiResponseToJson<T>(
  _ApiResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': _$nullableGenericToJson(instance.data, toJsonT),
  'meta': instance.meta,
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);
