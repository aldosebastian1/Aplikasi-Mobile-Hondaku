// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'motorcycle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MotorcycleFeature {

@JsonKey(includeFromJson: false, includeToJson: false) IconData? get icon; String get title; String get description;
/// Create a copy of MotorcycleFeature
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MotorcycleFeatureCopyWith<MotorcycleFeature> get copyWith => _$MotorcycleFeatureCopyWithImpl<MotorcycleFeature>(this as MotorcycleFeature, _$identity);

  /// Serializes this MotorcycleFeature to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MotorcycleFeature&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,icon,title,description);

@override
String toString() {
  return 'MotorcycleFeature(icon: $icon, title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class $MotorcycleFeatureCopyWith<$Res>  {
  factory $MotorcycleFeatureCopyWith(MotorcycleFeature value, $Res Function(MotorcycleFeature) _then) = _$MotorcycleFeatureCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false) IconData? icon, String title, String description
});




}
/// @nodoc
class _$MotorcycleFeatureCopyWithImpl<$Res>
    implements $MotorcycleFeatureCopyWith<$Res> {
  _$MotorcycleFeatureCopyWithImpl(this._self, this._then);

  final MotorcycleFeature _self;
  final $Res Function(MotorcycleFeature) _then;

/// Create a copy of MotorcycleFeature
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? icon = freezed,Object? title = null,Object? description = null,}) {
  return _then(_self.copyWith(
icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as IconData?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MotorcycleFeature].
extension MotorcycleFeaturePatterns on MotorcycleFeature {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MotorcycleFeature value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MotorcycleFeature() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MotorcycleFeature value)  $default,){
final _that = this;
switch (_that) {
case _MotorcycleFeature():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MotorcycleFeature value)?  $default,){
final _that = this;
switch (_that) {
case _MotorcycleFeature() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeFromJson: false, includeToJson: false)  IconData? icon,  String title,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MotorcycleFeature() when $default != null:
return $default(_that.icon,_that.title,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeFromJson: false, includeToJson: false)  IconData? icon,  String title,  String description)  $default,) {final _that = this;
switch (_that) {
case _MotorcycleFeature():
return $default(_that.icon,_that.title,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeFromJson: false, includeToJson: false)  IconData? icon,  String title,  String description)?  $default,) {final _that = this;
switch (_that) {
case _MotorcycleFeature() when $default != null:
return $default(_that.icon,_that.title,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MotorcycleFeature implements MotorcycleFeature {
  const _MotorcycleFeature({@JsonKey(includeFromJson: false, includeToJson: false) this.icon, required this.title, required this.description});
  factory _MotorcycleFeature.fromJson(Map<String, dynamic> json) => _$MotorcycleFeatureFromJson(json);

@override@JsonKey(includeFromJson: false, includeToJson: false) final  IconData? icon;
@override final  String title;
@override final  String description;

/// Create a copy of MotorcycleFeature
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MotorcycleFeatureCopyWith<_MotorcycleFeature> get copyWith => __$MotorcycleFeatureCopyWithImpl<_MotorcycleFeature>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MotorcycleFeatureToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MotorcycleFeature&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,icon,title,description);

@override
String toString() {
  return 'MotorcycleFeature(icon: $icon, title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class _$MotorcycleFeatureCopyWith<$Res> implements $MotorcycleFeatureCopyWith<$Res> {
  factory _$MotorcycleFeatureCopyWith(_MotorcycleFeature value, $Res Function(_MotorcycleFeature) _then) = __$MotorcycleFeatureCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false) IconData? icon, String title, String description
});




}
/// @nodoc
class __$MotorcycleFeatureCopyWithImpl<$Res>
    implements _$MotorcycleFeatureCopyWith<$Res> {
  __$MotorcycleFeatureCopyWithImpl(this._self, this._then);

  final _MotorcycleFeature _self;
  final $Res Function(_MotorcycleFeature) _then;

/// Create a copy of MotorcycleFeature
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? icon = freezed,Object? title = null,Object? description = null,}) {
  return _then(_MotorcycleFeature(
icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as IconData?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Motorcycle {

 String get id; String get name; String get categoryBadge; String get subtitle; String get description; String get price; String get imageAsset; bool get isNew; bool get isRecommended; String get engine; String get maxPower; String get fuelCapacity; List<MotorcycleFeature> get features; Map<String, String> get specsMesin; Map<String, String> get specsRangka; Map<String, String> get specsDimensi;
/// Create a copy of Motorcycle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MotorcycleCopyWith<Motorcycle> get copyWith => _$MotorcycleCopyWithImpl<Motorcycle>(this as Motorcycle, _$identity);

  /// Serializes this Motorcycle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Motorcycle&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.categoryBadge, categoryBadge) || other.categoryBadge == categoryBadge)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset)&&(identical(other.isNew, isNew) || other.isNew == isNew)&&(identical(other.isRecommended, isRecommended) || other.isRecommended == isRecommended)&&(identical(other.engine, engine) || other.engine == engine)&&(identical(other.maxPower, maxPower) || other.maxPower == maxPower)&&(identical(other.fuelCapacity, fuelCapacity) || other.fuelCapacity == fuelCapacity)&&const DeepCollectionEquality().equals(other.features, features)&&const DeepCollectionEquality().equals(other.specsMesin, specsMesin)&&const DeepCollectionEquality().equals(other.specsRangka, specsRangka)&&const DeepCollectionEquality().equals(other.specsDimensi, specsDimensi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,categoryBadge,subtitle,description,price,imageAsset,isNew,isRecommended,engine,maxPower,fuelCapacity,const DeepCollectionEquality().hash(features),const DeepCollectionEquality().hash(specsMesin),const DeepCollectionEquality().hash(specsRangka),const DeepCollectionEquality().hash(specsDimensi));

@override
String toString() {
  return 'Motorcycle(id: $id, name: $name, categoryBadge: $categoryBadge, subtitle: $subtitle, description: $description, price: $price, imageAsset: $imageAsset, isNew: $isNew, isRecommended: $isRecommended, engine: $engine, maxPower: $maxPower, fuelCapacity: $fuelCapacity, features: $features, specsMesin: $specsMesin, specsRangka: $specsRangka, specsDimensi: $specsDimensi)';
}


}

/// @nodoc
abstract mixin class $MotorcycleCopyWith<$Res>  {
  factory $MotorcycleCopyWith(Motorcycle value, $Res Function(Motorcycle) _then) = _$MotorcycleCopyWithImpl;
@useResult
$Res call({
 String id, String name, String categoryBadge, String subtitle, String description, String price, String imageAsset, bool isNew, bool isRecommended, String engine, String maxPower, String fuelCapacity, List<MotorcycleFeature> features, Map<String, String> specsMesin, Map<String, String> specsRangka, Map<String, String> specsDimensi
});




}
/// @nodoc
class _$MotorcycleCopyWithImpl<$Res>
    implements $MotorcycleCopyWith<$Res> {
  _$MotorcycleCopyWithImpl(this._self, this._then);

  final Motorcycle _self;
  final $Res Function(Motorcycle) _then;

/// Create a copy of Motorcycle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? categoryBadge = null,Object? subtitle = null,Object? description = null,Object? price = null,Object? imageAsset = null,Object? isNew = null,Object? isRecommended = null,Object? engine = null,Object? maxPower = null,Object? fuelCapacity = null,Object? features = null,Object? specsMesin = null,Object? specsRangka = null,Object? specsDimensi = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categoryBadge: null == categoryBadge ? _self.categoryBadge : categoryBadge // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,imageAsset: null == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String,isNew: null == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool,isRecommended: null == isRecommended ? _self.isRecommended : isRecommended // ignore: cast_nullable_to_non_nullable
as bool,engine: null == engine ? _self.engine : engine // ignore: cast_nullable_to_non_nullable
as String,maxPower: null == maxPower ? _self.maxPower : maxPower // ignore: cast_nullable_to_non_nullable
as String,fuelCapacity: null == fuelCapacity ? _self.fuelCapacity : fuelCapacity // ignore: cast_nullable_to_non_nullable
as String,features: null == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as List<MotorcycleFeature>,specsMesin: null == specsMesin ? _self.specsMesin : specsMesin // ignore: cast_nullable_to_non_nullable
as Map<String, String>,specsRangka: null == specsRangka ? _self.specsRangka : specsRangka // ignore: cast_nullable_to_non_nullable
as Map<String, String>,specsDimensi: null == specsDimensi ? _self.specsDimensi : specsDimensi // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Motorcycle].
extension MotorcyclePatterns on Motorcycle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Motorcycle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Motorcycle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Motorcycle value)  $default,){
final _that = this;
switch (_that) {
case _Motorcycle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Motorcycle value)?  $default,){
final _that = this;
switch (_that) {
case _Motorcycle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String categoryBadge,  String subtitle,  String description,  String price,  String imageAsset,  bool isNew,  bool isRecommended,  String engine,  String maxPower,  String fuelCapacity,  List<MotorcycleFeature> features,  Map<String, String> specsMesin,  Map<String, String> specsRangka,  Map<String, String> specsDimensi)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Motorcycle() when $default != null:
return $default(_that.id,_that.name,_that.categoryBadge,_that.subtitle,_that.description,_that.price,_that.imageAsset,_that.isNew,_that.isRecommended,_that.engine,_that.maxPower,_that.fuelCapacity,_that.features,_that.specsMesin,_that.specsRangka,_that.specsDimensi);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String categoryBadge,  String subtitle,  String description,  String price,  String imageAsset,  bool isNew,  bool isRecommended,  String engine,  String maxPower,  String fuelCapacity,  List<MotorcycleFeature> features,  Map<String, String> specsMesin,  Map<String, String> specsRangka,  Map<String, String> specsDimensi)  $default,) {final _that = this;
switch (_that) {
case _Motorcycle():
return $default(_that.id,_that.name,_that.categoryBadge,_that.subtitle,_that.description,_that.price,_that.imageAsset,_that.isNew,_that.isRecommended,_that.engine,_that.maxPower,_that.fuelCapacity,_that.features,_that.specsMesin,_that.specsRangka,_that.specsDimensi);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String categoryBadge,  String subtitle,  String description,  String price,  String imageAsset,  bool isNew,  bool isRecommended,  String engine,  String maxPower,  String fuelCapacity,  List<MotorcycleFeature> features,  Map<String, String> specsMesin,  Map<String, String> specsRangka,  Map<String, String> specsDimensi)?  $default,) {final _that = this;
switch (_that) {
case _Motorcycle() when $default != null:
return $default(_that.id,_that.name,_that.categoryBadge,_that.subtitle,_that.description,_that.price,_that.imageAsset,_that.isNew,_that.isRecommended,_that.engine,_that.maxPower,_that.fuelCapacity,_that.features,_that.specsMesin,_that.specsRangka,_that.specsDimensi);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _Motorcycle implements Motorcycle {
  const _Motorcycle({required this.id, required this.name, required this.categoryBadge, required this.subtitle, required this.description, required this.price, required this.imageAsset, this.isNew = false, this.isRecommended = false, required this.engine, required this.maxPower, required this.fuelCapacity, required final  List<MotorcycleFeature> features, required final  Map<String, String> specsMesin, required final  Map<String, String> specsRangka, required final  Map<String, String> specsDimensi}): _features = features,_specsMesin = specsMesin,_specsRangka = specsRangka,_specsDimensi = specsDimensi;
  factory _Motorcycle.fromJson(Map<String, dynamic> json) => _$MotorcycleFromJson(json);

@override final  String id;
@override final  String name;
@override final  String categoryBadge;
@override final  String subtitle;
@override final  String description;
@override final  String price;
@override final  String imageAsset;
@override@JsonKey() final  bool isNew;
@override@JsonKey() final  bool isRecommended;
@override final  String engine;
@override final  String maxPower;
@override final  String fuelCapacity;
 final  List<MotorcycleFeature> _features;
@override List<MotorcycleFeature> get features {
  if (_features is EqualUnmodifiableListView) return _features;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_features);
}

 final  Map<String, String> _specsMesin;
@override Map<String, String> get specsMesin {
  if (_specsMesin is EqualUnmodifiableMapView) return _specsMesin;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_specsMesin);
}

 final  Map<String, String> _specsRangka;
@override Map<String, String> get specsRangka {
  if (_specsRangka is EqualUnmodifiableMapView) return _specsRangka;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_specsRangka);
}

 final  Map<String, String> _specsDimensi;
@override Map<String, String> get specsDimensi {
  if (_specsDimensi is EqualUnmodifiableMapView) return _specsDimensi;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_specsDimensi);
}


/// Create a copy of Motorcycle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MotorcycleCopyWith<_Motorcycle> get copyWith => __$MotorcycleCopyWithImpl<_Motorcycle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MotorcycleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Motorcycle&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.categoryBadge, categoryBadge) || other.categoryBadge == categoryBadge)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset)&&(identical(other.isNew, isNew) || other.isNew == isNew)&&(identical(other.isRecommended, isRecommended) || other.isRecommended == isRecommended)&&(identical(other.engine, engine) || other.engine == engine)&&(identical(other.maxPower, maxPower) || other.maxPower == maxPower)&&(identical(other.fuelCapacity, fuelCapacity) || other.fuelCapacity == fuelCapacity)&&const DeepCollectionEquality().equals(other._features, _features)&&const DeepCollectionEquality().equals(other._specsMesin, _specsMesin)&&const DeepCollectionEquality().equals(other._specsRangka, _specsRangka)&&const DeepCollectionEquality().equals(other._specsDimensi, _specsDimensi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,categoryBadge,subtitle,description,price,imageAsset,isNew,isRecommended,engine,maxPower,fuelCapacity,const DeepCollectionEquality().hash(_features),const DeepCollectionEquality().hash(_specsMesin),const DeepCollectionEquality().hash(_specsRangka),const DeepCollectionEquality().hash(_specsDimensi));

@override
String toString() {
  return 'Motorcycle(id: $id, name: $name, categoryBadge: $categoryBadge, subtitle: $subtitle, description: $description, price: $price, imageAsset: $imageAsset, isNew: $isNew, isRecommended: $isRecommended, engine: $engine, maxPower: $maxPower, fuelCapacity: $fuelCapacity, features: $features, specsMesin: $specsMesin, specsRangka: $specsRangka, specsDimensi: $specsDimensi)';
}


}

/// @nodoc
abstract mixin class _$MotorcycleCopyWith<$Res> implements $MotorcycleCopyWith<$Res> {
  factory _$MotorcycleCopyWith(_Motorcycle value, $Res Function(_Motorcycle) _then) = __$MotorcycleCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String categoryBadge, String subtitle, String description, String price, String imageAsset, bool isNew, bool isRecommended, String engine, String maxPower, String fuelCapacity, List<MotorcycleFeature> features, Map<String, String> specsMesin, Map<String, String> specsRangka, Map<String, String> specsDimensi
});




}
/// @nodoc
class __$MotorcycleCopyWithImpl<$Res>
    implements _$MotorcycleCopyWith<$Res> {
  __$MotorcycleCopyWithImpl(this._self, this._then);

  final _Motorcycle _self;
  final $Res Function(_Motorcycle) _then;

/// Create a copy of Motorcycle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? categoryBadge = null,Object? subtitle = null,Object? description = null,Object? price = null,Object? imageAsset = null,Object? isNew = null,Object? isRecommended = null,Object? engine = null,Object? maxPower = null,Object? fuelCapacity = null,Object? features = null,Object? specsMesin = null,Object? specsRangka = null,Object? specsDimensi = null,}) {
  return _then(_Motorcycle(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categoryBadge: null == categoryBadge ? _self.categoryBadge : categoryBadge // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,imageAsset: null == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String,isNew: null == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool,isRecommended: null == isRecommended ? _self.isRecommended : isRecommended // ignore: cast_nullable_to_non_nullable
as bool,engine: null == engine ? _self.engine : engine // ignore: cast_nullable_to_non_nullable
as String,maxPower: null == maxPower ? _self.maxPower : maxPower // ignore: cast_nullable_to_non_nullable
as String,fuelCapacity: null == fuelCapacity ? _self.fuelCapacity : fuelCapacity // ignore: cast_nullable_to_non_nullable
as String,features: null == features ? _self._features : features // ignore: cast_nullable_to_non_nullable
as List<MotorcycleFeature>,specsMesin: null == specsMesin ? _self._specsMesin : specsMesin // ignore: cast_nullable_to_non_nullable
as Map<String, String>,specsRangka: null == specsRangka ? _self._specsRangka : specsRangka // ignore: cast_nullable_to_non_nullable
as Map<String, String>,specsDimensi: null == specsDimensi ? _self._specsDimensi : specsDimensi // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

// dart format on
