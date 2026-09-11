// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaginationMeta {

 int get currentPage; int get lastPage; int get total; int get perPage;
/// Create a copy of PaginationMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginationMetaCopyWith<PaginationMeta> get copyWith => _$PaginationMetaCopyWithImpl<PaginationMeta>(this as PaginationMeta, _$identity);

  /// Serializes this PaginationMeta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginationMeta&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.lastPage, lastPage) || other.lastPage == lastPage)&&(identical(other.total, total) || other.total == total)&&(identical(other.perPage, perPage) || other.perPage == perPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentPage,lastPage,total,perPage);

@override
String toString() {
  return 'PaginationMeta(currentPage: $currentPage, lastPage: $lastPage, total: $total, perPage: $perPage)';
}


}

/// @nodoc
abstract mixin class $PaginationMetaCopyWith<$Res>  {
  factory $PaginationMetaCopyWith(PaginationMeta value, $Res Function(PaginationMeta) _then) = _$PaginationMetaCopyWithImpl;
@useResult
$Res call({
 int currentPage, int lastPage, int total, int perPage
});




}
/// @nodoc
class _$PaginationMetaCopyWithImpl<$Res>
    implements $PaginationMetaCopyWith<$Res> {
  _$PaginationMetaCopyWithImpl(this._self, this._then);

  final PaginationMeta _self;
  final $Res Function(PaginationMeta) _then;

/// Create a copy of PaginationMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentPage = null,Object? lastPage = null,Object? total = null,Object? perPage = null,}) {
  return _then(_self.copyWith(
currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,lastPage: null == lastPage ? _self.lastPage : lastPage // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PaginationMeta].
extension PaginationMetaPatterns on PaginationMeta {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginationMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginationMeta() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginationMeta value)  $default,){
final _that = this;
switch (_that) {
case _PaginationMeta():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginationMeta value)?  $default,){
final _that = this;
switch (_that) {
case _PaginationMeta() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int currentPage,  int lastPage,  int total,  int perPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginationMeta() when $default != null:
return $default(_that.currentPage,_that.lastPage,_that.total,_that.perPage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int currentPage,  int lastPage,  int total,  int perPage)  $default,) {final _that = this;
switch (_that) {
case _PaginationMeta():
return $default(_that.currentPage,_that.lastPage,_that.total,_that.perPage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int currentPage,  int lastPage,  int total,  int perPage)?  $default,) {final _that = this;
switch (_that) {
case _PaginationMeta() when $default != null:
return $default(_that.currentPage,_that.lastPage,_that.total,_that.perPage);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _PaginationMeta implements PaginationMeta {
  const _PaginationMeta({this.currentPage = 1, this.lastPage = 1, this.total = 0, this.perPage = 15});
  factory _PaginationMeta.fromJson(Map<String, dynamic> json) => _$PaginationMetaFromJson(json);

@override@JsonKey() final  int currentPage;
@override@JsonKey() final  int lastPage;
@override@JsonKey() final  int total;
@override@JsonKey() final  int perPage;

/// Create a copy of PaginationMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginationMetaCopyWith<_PaginationMeta> get copyWith => __$PaginationMetaCopyWithImpl<_PaginationMeta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaginationMetaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginationMeta&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.lastPage, lastPage) || other.lastPage == lastPage)&&(identical(other.total, total) || other.total == total)&&(identical(other.perPage, perPage) || other.perPage == perPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentPage,lastPage,total,perPage);

@override
String toString() {
  return 'PaginationMeta(currentPage: $currentPage, lastPage: $lastPage, total: $total, perPage: $perPage)';
}


}

/// @nodoc
abstract mixin class _$PaginationMetaCopyWith<$Res> implements $PaginationMetaCopyWith<$Res> {
  factory _$PaginationMetaCopyWith(_PaginationMeta value, $Res Function(_PaginationMeta) _then) = __$PaginationMetaCopyWithImpl;
@override @useResult
$Res call({
 int currentPage, int lastPage, int total, int perPage
});




}
/// @nodoc
class __$PaginationMetaCopyWithImpl<$Res>
    implements _$PaginationMetaCopyWith<$Res> {
  __$PaginationMetaCopyWithImpl(this._self, this._then);

  final _PaginationMeta _self;
  final $Res Function(_PaginationMeta) _then;

/// Create a copy of PaginationMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentPage = null,Object? lastPage = null,Object? total = null,Object? perPage = null,}) {
  return _then(_PaginationMeta(
currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,lastPage: null == lastPage ? _self.lastPage : lastPage // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ApiResponse<T> {

@JsonKey(name: 'status') bool get status;@JsonKey(name: 'message') String get message;@JsonKey(name: 'data') T? get data;@JsonKey(name: 'meta') PaginationMeta? get meta;
/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiResponseCopyWith<T, ApiResponse<T>> get copyWith => _$ApiResponseCopyWithImpl<T, ApiResponse<T>>(this as ApiResponse<T>, _$identity);

  /// Serializes this ApiResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiResponse<T>&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.meta, meta) || other.meta == meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,message,const DeepCollectionEquality().hash(data),meta);

@override
String toString() {
  return 'ApiResponse<$T>(status: $status, message: $message, data: $data, meta: $meta)';
}


}

/// @nodoc
abstract mixin class $ApiResponseCopyWith<T,$Res>  {
  factory $ApiResponseCopyWith(ApiResponse<T> value, $Res Function(ApiResponse<T>) _then) = _$ApiResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'status') bool status,@JsonKey(name: 'message') String message,@JsonKey(name: 'data') T? data,@JsonKey(name: 'meta') PaginationMeta? meta
});


$PaginationMetaCopyWith<$Res>? get meta;

}
/// @nodoc
class _$ApiResponseCopyWithImpl<T,$Res>
    implements $ApiResponseCopyWith<T, $Res> {
  _$ApiResponseCopyWithImpl(this._self, this._then);

  final ApiResponse<T> _self;
  final $Res Function(ApiResponse<T>) _then;

/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? message = null,Object? data = freezed,Object? meta = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,meta: freezed == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as PaginationMeta?,
  ));
}
/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationMetaCopyWith<$Res>? get meta {
    if (_self.meta == null) {
    return null;
  }

  return $PaginationMetaCopyWith<$Res>(_self.meta!, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// Adds pattern-matching-related methods to [ApiResponse].
extension ApiResponsePatterns<T> on ApiResponse<T> {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiResponse<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiResponse<T> value)  $default,){
final _that = this;
switch (_that) {
case _ApiResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiResponse<T> value)?  $default,){
final _that = this;
switch (_that) {
case _ApiResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'status')  bool status, @JsonKey(name: 'message')  String message, @JsonKey(name: 'data')  T? data, @JsonKey(name: 'meta')  PaginationMeta? meta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiResponse() when $default != null:
return $default(_that.status,_that.message,_that.data,_that.meta);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'status')  bool status, @JsonKey(name: 'message')  String message, @JsonKey(name: 'data')  T? data, @JsonKey(name: 'meta')  PaginationMeta? meta)  $default,) {final _that = this;
switch (_that) {
case _ApiResponse():
return $default(_that.status,_that.message,_that.data,_that.meta);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'status')  bool status, @JsonKey(name: 'message')  String message, @JsonKey(name: 'data')  T? data, @JsonKey(name: 'meta')  PaginationMeta? meta)?  $default,) {final _that = this;
switch (_that) {
case _ApiResponse() when $default != null:
return $default(_that.status,_that.message,_that.data,_that.meta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _ApiResponse<T> implements ApiResponse<T> {
  const _ApiResponse({@JsonKey(name: 'status') this.status = false, @JsonKey(name: 'message') this.message = '', @JsonKey(name: 'data') this.data, @JsonKey(name: 'meta') this.meta});
  factory _ApiResponse.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$ApiResponseFromJson(json,fromJsonT);

@override@JsonKey(name: 'status') final  bool status;
@override@JsonKey(name: 'message') final  String message;
@override@JsonKey(name: 'data') final  T? data;
@override@JsonKey(name: 'meta') final  PaginationMeta? meta;

/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiResponseCopyWith<T, _ApiResponse<T>> get copyWith => __$ApiResponseCopyWithImpl<T, _ApiResponse<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$ApiResponseToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiResponse<T>&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.meta, meta) || other.meta == meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,message,const DeepCollectionEquality().hash(data),meta);

@override
String toString() {
  return 'ApiResponse<$T>(status: $status, message: $message, data: $data, meta: $meta)';
}


}

/// @nodoc
abstract mixin class _$ApiResponseCopyWith<T,$Res> implements $ApiResponseCopyWith<T, $Res> {
  factory _$ApiResponseCopyWith(_ApiResponse<T> value, $Res Function(_ApiResponse<T>) _then) = __$ApiResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'status') bool status,@JsonKey(name: 'message') String message,@JsonKey(name: 'data') T? data,@JsonKey(name: 'meta') PaginationMeta? meta
});


@override $PaginationMetaCopyWith<$Res>? get meta;

}
/// @nodoc
class __$ApiResponseCopyWithImpl<T,$Res>
    implements _$ApiResponseCopyWith<T, $Res> {
  __$ApiResponseCopyWithImpl(this._self, this._then);

  final _ApiResponse<T> _self;
  final $Res Function(_ApiResponse<T>) _then;

/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? message = null,Object? data = freezed,Object? meta = freezed,}) {
  return _then(_ApiResponse<T>(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,meta: freezed == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as PaginationMeta?,
  ));
}

/// Create a copy of ApiResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationMetaCopyWith<$Res>? get meta {
    if (_self.meta == null) {
    return null;
  }

  return $PaginationMetaCopyWith<$Res>(_self.meta!, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}

// dart format on
