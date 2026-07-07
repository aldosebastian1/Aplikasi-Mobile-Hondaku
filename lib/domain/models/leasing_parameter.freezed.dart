// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leasing_parameter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeasingParameter {

 String get id; String get name; String get subtitle; double get rateTahunan; double get minDpPersen; double get maxDpPersen; List<int> get tenorList;
/// Create a copy of LeasingParameter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeasingParameterCopyWith<LeasingParameter> get copyWith => _$LeasingParameterCopyWithImpl<LeasingParameter>(this as LeasingParameter, _$identity);

  /// Serializes this LeasingParameter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeasingParameter&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.rateTahunan, rateTahunan) || other.rateTahunan == rateTahunan)&&(identical(other.minDpPersen, minDpPersen) || other.minDpPersen == minDpPersen)&&(identical(other.maxDpPersen, maxDpPersen) || other.maxDpPersen == maxDpPersen)&&const DeepCollectionEquality().equals(other.tenorList, tenorList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,subtitle,rateTahunan,minDpPersen,maxDpPersen,const DeepCollectionEquality().hash(tenorList));

@override
String toString() {
  return 'LeasingParameter(id: $id, name: $name, subtitle: $subtitle, rateTahunan: $rateTahunan, minDpPersen: $minDpPersen, maxDpPersen: $maxDpPersen, tenorList: $tenorList)';
}


}

/// @nodoc
abstract mixin class $LeasingParameterCopyWith<$Res>  {
  factory $LeasingParameterCopyWith(LeasingParameter value, $Res Function(LeasingParameter) _then) = _$LeasingParameterCopyWithImpl;
@useResult
$Res call({
 String id, String name, String subtitle, double rateTahunan, double minDpPersen, double maxDpPersen, List<int> tenorList
});




}
/// @nodoc
class _$LeasingParameterCopyWithImpl<$Res>
    implements $LeasingParameterCopyWith<$Res> {
  _$LeasingParameterCopyWithImpl(this._self, this._then);

  final LeasingParameter _self;
  final $Res Function(LeasingParameter) _then;

/// Create a copy of LeasingParameter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? subtitle = null,Object? rateTahunan = null,Object? minDpPersen = null,Object? maxDpPersen = null,Object? tenorList = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,rateTahunan: null == rateTahunan ? _self.rateTahunan : rateTahunan // ignore: cast_nullable_to_non_nullable
as double,minDpPersen: null == minDpPersen ? _self.minDpPersen : minDpPersen // ignore: cast_nullable_to_non_nullable
as double,maxDpPersen: null == maxDpPersen ? _self.maxDpPersen : maxDpPersen // ignore: cast_nullable_to_non_nullable
as double,tenorList: null == tenorList ? _self.tenorList : tenorList // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [LeasingParameter].
extension LeasingParameterPatterns on LeasingParameter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeasingParameter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeasingParameter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeasingParameter value)  $default,){
final _that = this;
switch (_that) {
case _LeasingParameter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeasingParameter value)?  $default,){
final _that = this;
switch (_that) {
case _LeasingParameter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String subtitle,  double rateTahunan,  double minDpPersen,  double maxDpPersen,  List<int> tenorList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeasingParameter() when $default != null:
return $default(_that.id,_that.name,_that.subtitle,_that.rateTahunan,_that.minDpPersen,_that.maxDpPersen,_that.tenorList);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String subtitle,  double rateTahunan,  double minDpPersen,  double maxDpPersen,  List<int> tenorList)  $default,) {final _that = this;
switch (_that) {
case _LeasingParameter():
return $default(_that.id,_that.name,_that.subtitle,_that.rateTahunan,_that.minDpPersen,_that.maxDpPersen,_that.tenorList);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String subtitle,  double rateTahunan,  double minDpPersen,  double maxDpPersen,  List<int> tenorList)?  $default,) {final _that = this;
switch (_that) {
case _LeasingParameter() when $default != null:
return $default(_that.id,_that.name,_that.subtitle,_that.rateTahunan,_that.minDpPersen,_that.maxDpPersen,_that.tenorList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeasingParameter implements LeasingParameter {
  const _LeasingParameter({required this.id, required this.name, required this.subtitle, required this.rateTahunan, required this.minDpPersen, required this.maxDpPersen, required final  List<int> tenorList}): _tenorList = tenorList;
  factory _LeasingParameter.fromJson(Map<String, dynamic> json) => _$LeasingParameterFromJson(json);

@override final  String id;
@override final  String name;
@override final  String subtitle;
@override final  double rateTahunan;
@override final  double minDpPersen;
@override final  double maxDpPersen;
 final  List<int> _tenorList;
@override List<int> get tenorList {
  if (_tenorList is EqualUnmodifiableListView) return _tenorList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tenorList);
}


/// Create a copy of LeasingParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeasingParameterCopyWith<_LeasingParameter> get copyWith => __$LeasingParameterCopyWithImpl<_LeasingParameter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeasingParameterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeasingParameter&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.rateTahunan, rateTahunan) || other.rateTahunan == rateTahunan)&&(identical(other.minDpPersen, minDpPersen) || other.minDpPersen == minDpPersen)&&(identical(other.maxDpPersen, maxDpPersen) || other.maxDpPersen == maxDpPersen)&&const DeepCollectionEquality().equals(other._tenorList, _tenorList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,subtitle,rateTahunan,minDpPersen,maxDpPersen,const DeepCollectionEquality().hash(_tenorList));

@override
String toString() {
  return 'LeasingParameter(id: $id, name: $name, subtitle: $subtitle, rateTahunan: $rateTahunan, minDpPersen: $minDpPersen, maxDpPersen: $maxDpPersen, tenorList: $tenorList)';
}


}

/// @nodoc
abstract mixin class _$LeasingParameterCopyWith<$Res> implements $LeasingParameterCopyWith<$Res> {
  factory _$LeasingParameterCopyWith(_LeasingParameter value, $Res Function(_LeasingParameter) _then) = __$LeasingParameterCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String subtitle, double rateTahunan, double minDpPersen, double maxDpPersen, List<int> tenorList
});




}
/// @nodoc
class __$LeasingParameterCopyWithImpl<$Res>
    implements _$LeasingParameterCopyWith<$Res> {
  __$LeasingParameterCopyWithImpl(this._self, this._then);

  final _LeasingParameter _self;
  final $Res Function(_LeasingParameter) _then;

/// Create a copy of LeasingParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? subtitle = null,Object? rateTahunan = null,Object? minDpPersen = null,Object? maxDpPersen = null,Object? tenorList = null,}) {
  return _then(_LeasingParameter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,rateTahunan: null == rateTahunan ? _self.rateTahunan : rateTahunan // ignore: cast_nullable_to_non_nullable
as double,minDpPersen: null == minDpPersen ? _self.minDpPersen : minDpPersen // ignore: cast_nullable_to_non_nullable
as double,maxDpPersen: null == maxDpPersen ? _self.maxDpPersen : maxDpPersen // ignore: cast_nullable_to_non_nullable
as double,tenorList: null == tenorList ? _self._tenorList : tenorList // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
