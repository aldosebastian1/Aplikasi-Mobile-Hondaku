// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kecamatan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Kecamatan {

 String get id; String get name; List<String> get kelurahan;
/// Create a copy of Kecamatan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KecamatanCopyWith<Kecamatan> get copyWith => _$KecamatanCopyWithImpl<Kecamatan>(this as Kecamatan, _$identity);

  /// Serializes this Kecamatan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Kecamatan&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.kelurahan, kelurahan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(kelurahan));

@override
String toString() {
  return 'Kecamatan(id: $id, name: $name, kelurahan: $kelurahan)';
}


}

/// @nodoc
abstract mixin class $KecamatanCopyWith<$Res>  {
  factory $KecamatanCopyWith(Kecamatan value, $Res Function(Kecamatan) _then) = _$KecamatanCopyWithImpl;
@useResult
$Res call({
 String id, String name, List<String> kelurahan
});




}
/// @nodoc
class _$KecamatanCopyWithImpl<$Res>
    implements $KecamatanCopyWith<$Res> {
  _$KecamatanCopyWithImpl(this._self, this._then);

  final Kecamatan _self;
  final $Res Function(Kecamatan) _then;

/// Create a copy of Kecamatan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? kelurahan = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kelurahan: null == kelurahan ? _self.kelurahan : kelurahan // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Kecamatan].
extension KecamatanPatterns on Kecamatan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Kecamatan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Kecamatan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Kecamatan value)  $default,){
final _that = this;
switch (_that) {
case _Kecamatan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Kecamatan value)?  $default,){
final _that = this;
switch (_that) {
case _Kecamatan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  List<String> kelurahan)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Kecamatan() when $default != null:
return $default(_that.id,_that.name,_that.kelurahan);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  List<String> kelurahan)  $default,) {final _that = this;
switch (_that) {
case _Kecamatan():
return $default(_that.id,_that.name,_that.kelurahan);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  List<String> kelurahan)?  $default,) {final _that = this;
switch (_that) {
case _Kecamatan() when $default != null:
return $default(_that.id,_that.name,_that.kelurahan);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Kecamatan implements Kecamatan {
  const _Kecamatan({required this.id, required this.name, required final  List<String> kelurahan}): _kelurahan = kelurahan;
  factory _Kecamatan.fromJson(Map<String, dynamic> json) => _$KecamatanFromJson(json);

@override final  String id;
@override final  String name;
 final  List<String> _kelurahan;
@override List<String> get kelurahan {
  if (_kelurahan is EqualUnmodifiableListView) return _kelurahan;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_kelurahan);
}


/// Create a copy of Kecamatan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KecamatanCopyWith<_Kecamatan> get copyWith => __$KecamatanCopyWithImpl<_Kecamatan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KecamatanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Kecamatan&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._kelurahan, _kelurahan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_kelurahan));

@override
String toString() {
  return 'Kecamatan(id: $id, name: $name, kelurahan: $kelurahan)';
}


}

/// @nodoc
abstract mixin class _$KecamatanCopyWith<$Res> implements $KecamatanCopyWith<$Res> {
  factory _$KecamatanCopyWith(_Kecamatan value, $Res Function(_Kecamatan) _then) = __$KecamatanCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, List<String> kelurahan
});




}
/// @nodoc
class __$KecamatanCopyWithImpl<$Res>
    implements _$KecamatanCopyWith<$Res> {
  __$KecamatanCopyWithImpl(this._self, this._then);

  final _Kecamatan _self;
  final $Res Function(_Kecamatan) _then;

/// Create a copy of Kecamatan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? kelurahan = null,}) {
  return _then(_Kecamatan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kelurahan: null == kelurahan ? _self._kelurahan : kelurahan // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
