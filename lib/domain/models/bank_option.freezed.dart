// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bank_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BankOption {

 String get name; String get logoPath;
/// Create a copy of BankOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BankOptionCopyWith<BankOption> get copyWith => _$BankOptionCopyWithImpl<BankOption>(this as BankOption, _$identity);

  /// Serializes this BankOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BankOption&&(identical(other.name, name) || other.name == name)&&(identical(other.logoPath, logoPath) || other.logoPath == logoPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,logoPath);

@override
String toString() {
  return 'BankOption(name: $name, logoPath: $logoPath)';
}


}

/// @nodoc
abstract mixin class $BankOptionCopyWith<$Res>  {
  factory $BankOptionCopyWith(BankOption value, $Res Function(BankOption) _then) = _$BankOptionCopyWithImpl;
@useResult
$Res call({
 String name, String logoPath
});




}
/// @nodoc
class _$BankOptionCopyWithImpl<$Res>
    implements $BankOptionCopyWith<$Res> {
  _$BankOptionCopyWithImpl(this._self, this._then);

  final BankOption _self;
  final $Res Function(BankOption) _then;

/// Create a copy of BankOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? logoPath = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,logoPath: null == logoPath ? _self.logoPath : logoPath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BankOption].
extension BankOptionPatterns on BankOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BankOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BankOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BankOption value)  $default,){
final _that = this;
switch (_that) {
case _BankOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BankOption value)?  $default,){
final _that = this;
switch (_that) {
case _BankOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String logoPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BankOption() when $default != null:
return $default(_that.name,_that.logoPath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String logoPath)  $default,) {final _that = this;
switch (_that) {
case _BankOption():
return $default(_that.name,_that.logoPath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String logoPath)?  $default,) {final _that = this;
switch (_that) {
case _BankOption() when $default != null:
return $default(_that.name,_that.logoPath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BankOption implements BankOption {
  const _BankOption({required this.name, required this.logoPath});
  factory _BankOption.fromJson(Map<String, dynamic> json) => _$BankOptionFromJson(json);

@override final  String name;
@override final  String logoPath;

/// Create a copy of BankOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BankOptionCopyWith<_BankOption> get copyWith => __$BankOptionCopyWithImpl<_BankOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BankOptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BankOption&&(identical(other.name, name) || other.name == name)&&(identical(other.logoPath, logoPath) || other.logoPath == logoPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,logoPath);

@override
String toString() {
  return 'BankOption(name: $name, logoPath: $logoPath)';
}


}

/// @nodoc
abstract mixin class _$BankOptionCopyWith<$Res> implements $BankOptionCopyWith<$Res> {
  factory _$BankOptionCopyWith(_BankOption value, $Res Function(_BankOption) _then) = __$BankOptionCopyWithImpl;
@override @useResult
$Res call({
 String name, String logoPath
});




}
/// @nodoc
class __$BankOptionCopyWithImpl<$Res>
    implements _$BankOptionCopyWith<$Res> {
  __$BankOptionCopyWithImpl(this._self, this._then);

  final _BankOption _self;
  final $Res Function(_BankOption) _then;

/// Create a copy of BankOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? logoPath = null,}) {
  return _then(_BankOption(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,logoPath: null == logoPath ? _self.logoPath : logoPath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
