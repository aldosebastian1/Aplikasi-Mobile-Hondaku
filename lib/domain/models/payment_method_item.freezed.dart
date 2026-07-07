// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_method_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaymentMethodItem {

 String get id; String get title; String get subtitle; String get logoPath; bool get isDefault; String get type;
/// Create a copy of PaymentMethodItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentMethodItemCopyWith<PaymentMethodItem> get copyWith => _$PaymentMethodItemCopyWithImpl<PaymentMethodItem>(this as PaymentMethodItem, _$identity);

  /// Serializes this PaymentMethodItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentMethodItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.logoPath, logoPath) || other.logoPath == logoPath)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,subtitle,logoPath,isDefault,type);

@override
String toString() {
  return 'PaymentMethodItem(id: $id, title: $title, subtitle: $subtitle, logoPath: $logoPath, isDefault: $isDefault, type: $type)';
}


}

/// @nodoc
abstract mixin class $PaymentMethodItemCopyWith<$Res>  {
  factory $PaymentMethodItemCopyWith(PaymentMethodItem value, $Res Function(PaymentMethodItem) _then) = _$PaymentMethodItemCopyWithImpl;
@useResult
$Res call({
 String id, String title, String subtitle, String logoPath, bool isDefault, String type
});




}
/// @nodoc
class _$PaymentMethodItemCopyWithImpl<$Res>
    implements $PaymentMethodItemCopyWith<$Res> {
  _$PaymentMethodItemCopyWithImpl(this._self, this._then);

  final PaymentMethodItem _self;
  final $Res Function(PaymentMethodItem) _then;

/// Create a copy of PaymentMethodItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? subtitle = null,Object? logoPath = null,Object? isDefault = null,Object? type = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,logoPath: null == logoPath ? _self.logoPath : logoPath // ignore: cast_nullable_to_non_nullable
as String,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentMethodItem].
extension PaymentMethodItemPatterns on PaymentMethodItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentMethodItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentMethodItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentMethodItem value)  $default,){
final _that = this;
switch (_that) {
case _PaymentMethodItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentMethodItem value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentMethodItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String subtitle,  String logoPath,  bool isDefault,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentMethodItem() when $default != null:
return $default(_that.id,_that.title,_that.subtitle,_that.logoPath,_that.isDefault,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String subtitle,  String logoPath,  bool isDefault,  String type)  $default,) {final _that = this;
switch (_that) {
case _PaymentMethodItem():
return $default(_that.id,_that.title,_that.subtitle,_that.logoPath,_that.isDefault,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String subtitle,  String logoPath,  bool isDefault,  String type)?  $default,) {final _that = this;
switch (_that) {
case _PaymentMethodItem() when $default != null:
return $default(_that.id,_that.title,_that.subtitle,_that.logoPath,_that.isDefault,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentMethodItem implements PaymentMethodItem {
  const _PaymentMethodItem({required this.id, required this.title, required this.subtitle, required this.logoPath, this.isDefault = false, required this.type});
  factory _PaymentMethodItem.fromJson(Map<String, dynamic> json) => _$PaymentMethodItemFromJson(json);

@override final  String id;
@override final  String title;
@override final  String subtitle;
@override final  String logoPath;
@override@JsonKey() final  bool isDefault;
@override final  String type;

/// Create a copy of PaymentMethodItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentMethodItemCopyWith<_PaymentMethodItem> get copyWith => __$PaymentMethodItemCopyWithImpl<_PaymentMethodItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentMethodItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentMethodItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.logoPath, logoPath) || other.logoPath == logoPath)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,subtitle,logoPath,isDefault,type);

@override
String toString() {
  return 'PaymentMethodItem(id: $id, title: $title, subtitle: $subtitle, logoPath: $logoPath, isDefault: $isDefault, type: $type)';
}


}

/// @nodoc
abstract mixin class _$PaymentMethodItemCopyWith<$Res> implements $PaymentMethodItemCopyWith<$Res> {
  factory _$PaymentMethodItemCopyWith(_PaymentMethodItem value, $Res Function(_PaymentMethodItem) _then) = __$PaymentMethodItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String subtitle, String logoPath, bool isDefault, String type
});




}
/// @nodoc
class __$PaymentMethodItemCopyWithImpl<$Res>
    implements _$PaymentMethodItemCopyWith<$Res> {
  __$PaymentMethodItemCopyWithImpl(this._self, this._then);

  final _PaymentMethodItem _self;
  final $Res Function(_PaymentMethodItem) _then;

/// Create a copy of PaymentMethodItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? subtitle = null,Object? logoPath = null,Object? isDefault = null,Object? type = null,}) {
  return _then(_PaymentMethodItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,logoPath: null == logoPath ? _self.logoPath : logoPath // ignore: cast_nullable_to_non_nullable
as String,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
