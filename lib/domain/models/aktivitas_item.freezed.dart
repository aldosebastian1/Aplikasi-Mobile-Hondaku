// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'aktivitas_item.dart';

// FreezedGenerator

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AktivitasItem {

 String get id; String get namaMotor; String get tipeUnit; String get dealer; String get imagePath; DateTime get tanggal; TipeTransaksi get tipe; StatusAktivitas get status;
/// Create a copy of AktivitasItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AktivitasItemCopyWith<AktivitasItem> get copyWith => _$AktivitasItemCopyWithImpl<AktivitasItem>(this as AktivitasItem, _$identity);

  /// Serializes this AktivitasItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AktivitasItem&&(identical(other.id, id) || other.id == id)&&(identical(other.namaMotor, namaMotor) || other.namaMotor == namaMotor)&&(identical(other.tipeUnit, tipeUnit) || other.tipeUnit == tipeUnit)&&(identical(other.dealer, dealer) || other.dealer == dealer)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.tanggal, tanggal) || other.tanggal == tanggal)&&(identical(other.tipe, tipe) || other.tipe == tipe)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,namaMotor,tipeUnit,dealer,imagePath,tanggal,tipe,status);

@override
String toString() {
  return 'AktivitasItem(id: $id, namaMotor: $namaMotor, tipeUnit: $tipeUnit, dealer: $dealer, imagePath: $imagePath, tanggal: $tanggal, tipe: $tipe, status: $status)';
}


}

/// @nodoc
abstract mixin class $AktivitasItemCopyWith<$Res>  {
  factory $AktivitasItemCopyWith(AktivitasItem value, $Res Function(AktivitasItem) _then) = _$AktivitasItemCopyWithImpl;
@useResult
$Res call({
 String id, String namaMotor, String tipeUnit, String dealer, String imagePath, DateTime tanggal, TipeTransaksi tipe, StatusAktivitas status
});




}
/// @nodoc
class _$AktivitasItemCopyWithImpl<$Res>
    implements $AktivitasItemCopyWith<$Res> {
  _$AktivitasItemCopyWithImpl(this._self, this._then);

  final AktivitasItem _self;
  final $Res Function(AktivitasItem) _then;

/// Create a copy of AktivitasItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? namaMotor = null,Object? tipeUnit = null,Object? dealer = null,Object? imagePath = null,Object? tanggal = null,Object? tipe = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,namaMotor: null == namaMotor ? _self.namaMotor : namaMotor // ignore: cast_nullable_to_non_nullable
as String,tipeUnit: null == tipeUnit ? _self.tipeUnit : tipeUnit // ignore: cast_nullable_to_non_nullable
as String,dealer: null == dealer ? _self.dealer : dealer // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,tanggal: null == tanggal ? _self.tanggal : tanggal // ignore: cast_nullable_to_non_nullable
as DateTime,tipe: null == tipe ? _self.tipe : tipe // ignore: cast_nullable_to_non_nullable
as TipeTransaksi,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StatusAktivitas,
  ));
}

}


/// Adds pattern-matching-related methods to [AktivitasItem].
extension AktivitasItemPatterns on AktivitasItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AktivitasItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AktivitasItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AktivitasItem value)  $default,){
final _that = this;
switch (_that) {
case _AktivitasItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AktivitasItem value)?  $default,){
final _that = this;
switch (_that) {
case _AktivitasItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String namaMotor,  String tipeUnit,  String dealer,  String imagePath,  DateTime tanggal,  TipeTransaksi tipe,  StatusAktivitas status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AktivitasItem() when $default != null:
return $default(_that.id,_that.namaMotor,_that.tipeUnit,_that.dealer,_that.imagePath,_that.tanggal,_that.tipe,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String namaMotor,  String tipeUnit,  String dealer,  String imagePath,  DateTime tanggal,  TipeTransaksi tipe,  StatusAktivitas status)  $default,) {final _that = this;
switch (_that) {
case _AktivitasItem():
return $default(_that.id,_that.namaMotor,_that.tipeUnit,_that.dealer,_that.imagePath,_that.tanggal,_that.tipe,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String namaMotor,  String tipeUnit,  String dealer,  String imagePath,  DateTime tanggal,  TipeTransaksi tipe,  StatusAktivitas status)?  $default,) {final _that = this;
switch (_that) {
case _AktivitasItem() when $default != null:
return $default(_that.id,_that.namaMotor,_that.tipeUnit,_that.dealer,_that.imagePath,_that.tanggal,_that.tipe,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AktivitasItem implements AktivitasItem {
  const _AktivitasItem({required this.id, required this.namaMotor, required this.tipeUnit, required this.dealer, required this.imagePath, required this.tanggal, required this.tipe, required this.status});
  factory _AktivitasItem.fromJson(Map<String, dynamic> json) => _$AktivitasItemFromJson(json);

@override final  String id;
@override final  String namaMotor;
@override final  String tipeUnit;
@override final  String dealer;
@override final  String imagePath;
@override final  DateTime tanggal;
@override final  TipeTransaksi tipe;
@override final  StatusAktivitas status;

/// Create a copy of AktivitasItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AktivitasItemCopyWith<_AktivitasItem> get copyWith => __$AktivitasItemCopyWithImpl<_AktivitasItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AktivitasItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AktivitasItem&&(identical(other.id, id) || other.id == id)&&(identical(other.namaMotor, namaMotor) || other.namaMotor == namaMotor)&&(identical(other.tipeUnit, tipeUnit) || other.tipeUnit == tipeUnit)&&(identical(other.dealer, dealer) || other.dealer == dealer)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.tanggal, tanggal) || other.tanggal == tanggal)&&(identical(other.tipe, tipe) || other.tipe == tipe)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,namaMotor,tipeUnit,dealer,imagePath,tanggal,tipe,status);

@override
String toString() {
  return 'AktivitasItem(id: $id, namaMotor: $namaMotor, tipeUnit: $tipeUnit, dealer: $dealer, imagePath: $imagePath, tanggal: $tanggal, tipe: $tipe, status: $status)';
}


}

/// @nodoc
abstract mixin class _$AktivitasItemCopyWith<$Res> implements $AktivitasItemCopyWith<$Res> {
  factory _$AktivitasItemCopyWith(_AktivitasItem value, $Res Function(_AktivitasItem) _then) = __$AktivitasItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String namaMotor, String tipeUnit, String dealer, String imagePath, DateTime tanggal, TipeTransaksi tipe, StatusAktivitas status
});




}
/// @nodoc
class __$AktivitasItemCopyWithImpl<$Res>
    implements _$AktivitasItemCopyWith<$Res> {
  __$AktivitasItemCopyWithImpl(this._self, this._then);

  final _AktivitasItem _self;
  final $Res Function(_AktivitasItem) _then;

/// Create a copy of AktivitasItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? namaMotor = null,Object? tipeUnit = null,Object? dealer = null,Object? imagePath = null,Object? tanggal = null,Object? tipe = null,Object? status = null,}) {
  return _then(_AktivitasItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,namaMotor: null == namaMotor ? _self.namaMotor : namaMotor // ignore: cast_nullable_to_non_nullable
as String,tipeUnit: null == tipeUnit ? _self.tipeUnit : tipeUnit // ignore: cast_nullable_to_non_nullable
as String,dealer: null == dealer ? _self.dealer : dealer // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,tanggal: null == tanggal ? _self.tanggal : tanggal // ignore: cast_nullable_to_non_nullable
as DateTime,tipe: null == tipe ? _self.tipe : tipe // ignore: cast_nullable_to_non_nullable
as TipeTransaksi,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StatusAktivitas,
  ));
}


}

// dart format on
