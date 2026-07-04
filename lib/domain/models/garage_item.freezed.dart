// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'garage_item.dart';

// FreezedGenerator

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GarageItem {

 String get id; String get name; String get type; String get imagePath; String get category;
/// Create a copy of GarageItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GarageItemCopyWith<GarageItem> get copyWith => _$GarageItemCopyWithImpl<GarageItem>(this as GarageItem, _$identity);

  /// Serializes this GarageItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GarageItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,imagePath,category);

@override
String toString() {
  return 'GarageItem(id: $id, name: $name, type: $type, imagePath: $imagePath, category: $category)';
}


}

/// @nodoc
abstract mixin class $GarageItemCopyWith<$Res>  {
  factory $GarageItemCopyWith(GarageItem value, $Res Function(GarageItem) _then) = _$GarageItemCopyWithImpl;
@useResult
$Res call({
 String id, String name, String type, String imagePath, String category
});




}
/// @nodoc
class _$GarageItemCopyWithImpl<$Res>
    implements $GarageItemCopyWith<$Res> {
  _$GarageItemCopyWithImpl(this._self, this._then);

  final GarageItem _self;
  final $Res Function(GarageItem) _then;

/// Create a copy of GarageItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? imagePath = null,Object? category = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GarageItem].
extension GarageItemPatterns on GarageItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GarageItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GarageItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GarageItem value)  $default,){
final _that = this;
switch (_that) {
case _GarageItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GarageItem value)?  $default,){
final _that = this;
switch (_that) {
case _GarageItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String type,  String imagePath,  String category)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GarageItem() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.imagePath,_that.category);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String type,  String imagePath,  String category)  $default,) {final _that = this;
switch (_that) {
case _GarageItem():
return $default(_that.id,_that.name,_that.type,_that.imagePath,_that.category);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String type,  String imagePath,  String category)?  $default,) {final _that = this;
switch (_that) {
case _GarageItem() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.imagePath,_that.category);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GarageItem implements GarageItem {
  const _GarageItem({required this.id, required this.name, required this.type, required this.imagePath, required this.category});
  factory _GarageItem.fromJson(Map<String, dynamic> json) => _$GarageItemFromJson(json);

@override final  String id;
@override final  String name;
@override final  String type;
@override final  String imagePath;
@override final  String category;

/// Create a copy of GarageItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GarageItemCopyWith<_GarageItem> get copyWith => __$GarageItemCopyWithImpl<_GarageItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GarageItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GarageItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,imagePath,category);

@override
String toString() {
  return 'GarageItem(id: $id, name: $name, type: $type, imagePath: $imagePath, category: $category)';
}


}

/// @nodoc
abstract mixin class _$GarageItemCopyWith<$Res> implements $GarageItemCopyWith<$Res> {
  factory _$GarageItemCopyWith(_GarageItem value, $Res Function(_GarageItem) _then) = __$GarageItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String type, String imagePath, String category
});




}
/// @nodoc
class __$GarageItemCopyWithImpl<$Res>
    implements _$GarageItemCopyWith<$Res> {
  __$GarageItemCopyWithImpl(this._self, this._then);

  final _GarageItem _self;
  final $Res Function(_GarageItem) _then;

/// Create a copy of GarageItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? imagePath = null,Object? category = null,}) {
  return _then(_GarageItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
