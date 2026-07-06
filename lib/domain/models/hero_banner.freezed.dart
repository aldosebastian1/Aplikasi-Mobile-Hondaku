// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hero_banner.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HeroBanner {

 String get image; String get tag; String get title1; String get title2; String get subtitle;
/// Create a copy of HeroBanner
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HeroBannerCopyWith<HeroBanner> get copyWith => _$HeroBannerCopyWithImpl<HeroBanner>(this as HeroBanner, _$identity);

  /// Serializes this HeroBanner to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeroBanner&&(identical(other.image, image) || other.image == image)&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.title1, title1) || other.title1 == title1)&&(identical(other.title2, title2) || other.title2 == title2)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,image,tag,title1,title2,subtitle);

@override
String toString() {
  return 'HeroBanner(image: $image, tag: $tag, title1: $title1, title2: $title2, subtitle: $subtitle)';
}


}

/// @nodoc
abstract mixin class $HeroBannerCopyWith<$Res>  {
  factory $HeroBannerCopyWith(HeroBanner value, $Res Function(HeroBanner) _then) = _$HeroBannerCopyWithImpl;
@useResult
$Res call({
 String image, String tag, String title1, String title2, String subtitle
});




}
/// @nodoc
class _$HeroBannerCopyWithImpl<$Res>
    implements $HeroBannerCopyWith<$Res> {
  _$HeroBannerCopyWithImpl(this._self, this._then);

  final HeroBanner _self;
  final $Res Function(HeroBanner) _then;

/// Create a copy of HeroBanner
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? image = null,Object? tag = null,Object? title1 = null,Object? title2 = null,Object? subtitle = null,}) {
  return _then(_self.copyWith(
image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String,title1: null == title1 ? _self.title1 : title1 // ignore: cast_nullable_to_non_nullable
as String,title2: null == title2 ? _self.title2 : title2 // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HeroBanner].
extension HeroBannerPatterns on HeroBanner {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HeroBanner value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HeroBanner() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HeroBanner value)  $default,){
final _that = this;
switch (_that) {
case _HeroBanner():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HeroBanner value)?  $default,){
final _that = this;
switch (_that) {
case _HeroBanner() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String image,  String tag,  String title1,  String title2,  String subtitle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HeroBanner() when $default != null:
return $default(_that.image,_that.tag,_that.title1,_that.title2,_that.subtitle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String image,  String tag,  String title1,  String title2,  String subtitle)  $default,) {final _that = this;
switch (_that) {
case _HeroBanner():
return $default(_that.image,_that.tag,_that.title1,_that.title2,_that.subtitle);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String image,  String tag,  String title1,  String title2,  String subtitle)?  $default,) {final _that = this;
switch (_that) {
case _HeroBanner() when $default != null:
return $default(_that.image,_that.tag,_that.title1,_that.title2,_that.subtitle);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HeroBanner implements HeroBanner {
  const _HeroBanner({required this.image, required this.tag, required this.title1, required this.title2, required this.subtitle});
  factory _HeroBanner.fromJson(Map<String, dynamic> json) => _$HeroBannerFromJson(json);

@override final  String image;
@override final  String tag;
@override final  String title1;
@override final  String title2;
@override final  String subtitle;

/// Create a copy of HeroBanner
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HeroBannerCopyWith<_HeroBanner> get copyWith => __$HeroBannerCopyWithImpl<_HeroBanner>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HeroBannerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HeroBanner&&(identical(other.image, image) || other.image == image)&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.title1, title1) || other.title1 == title1)&&(identical(other.title2, title2) || other.title2 == title2)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,image,tag,title1,title2,subtitle);

@override
String toString() {
  return 'HeroBanner(image: $image, tag: $tag, title1: $title1, title2: $title2, subtitle: $subtitle)';
}


}

/// @nodoc
abstract mixin class _$HeroBannerCopyWith<$Res> implements $HeroBannerCopyWith<$Res> {
  factory _$HeroBannerCopyWith(_HeroBanner value, $Res Function(_HeroBanner) _then) = __$HeroBannerCopyWithImpl;
@override @useResult
$Res call({
 String image, String tag, String title1, String title2, String subtitle
});




}
/// @nodoc
class __$HeroBannerCopyWithImpl<$Res>
    implements _$HeroBannerCopyWith<$Res> {
  __$HeroBannerCopyWithImpl(this._self, this._then);

  final _HeroBanner _self;
  final $Res Function(_HeroBanner) _then;

/// Create a copy of HeroBanner
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? image = null,Object? tag = null,Object? title1 = null,Object? title2 = null,Object? subtitle = null,}) {
  return _then(_HeroBanner(
image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String,title1: null == title1 ? _self.title1 : title1 // ignore: cast_nullable_to_non_nullable
as String,title2: null == title2 ? _self.title2 : title2 // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
