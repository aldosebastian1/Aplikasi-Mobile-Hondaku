import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

// Standar Super App: Dukungan Pagination (Halaman)
// Aplikasi skala besar tidak pernah memuat semua katalog motor sekaligus.
// Mereka menggunakan Infinite Scroll. Meta ini menangkap data halaman dari API.
@freezed
abstract class PaginationMeta with _$PaginationMeta {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PaginationMeta({
    @Default(1) int currentPage,
    @Default(1) int lastPage,
    @Default(0) int total,
    @Default(15) int perPage,
  }) = _PaginationMeta;

  factory PaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaFromJson(json);
}

@Freezed(genericArgumentFactories: true)
abstract class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    // Menyediakan Default Value dan memastikan Null Safety
    @Default(false) @JsonKey(name: 'status') bool status,
    @Default('') @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') T? data,
    // Ekstensi Enterprise: Menangkap Metadata (seperti Pagination)
    @JsonKey(name: 'meta') PaginationMeta? meta, 
  }) = _ApiResponse;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);
}
