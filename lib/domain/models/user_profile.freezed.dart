// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfile {

 String get nama; String get username; String get email; String get phone; String get nik; String get avatarPath; bool get isCustomAvatar;@ColorConverter() Color get avatarBgColor; String get initials;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.nama, nama) || other.nama == nama)&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.nik, nik) || other.nik == nik)&&(identical(other.avatarPath, avatarPath) || other.avatarPath == avatarPath)&&(identical(other.isCustomAvatar, isCustomAvatar) || other.isCustomAvatar == isCustomAvatar)&&(identical(other.avatarBgColor, avatarBgColor) || other.avatarBgColor == avatarBgColor)&&(identical(other.initials, initials) || other.initials == initials));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nama,username,email,phone,nik,avatarPath,isCustomAvatar,avatarBgColor,initials);

@override
String toString() {
  return 'UserProfile(nama: $nama, username: $username, email: $email, phone: $phone, nik: $nik, avatarPath: $avatarPath, isCustomAvatar: $isCustomAvatar, avatarBgColor: $avatarBgColor, initials: $initials)';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 String nama, String username, String email, String phone, String nik, String avatarPath, bool isCustomAvatar,@ColorConverter() Color avatarBgColor, String initials
});




}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nama = null,Object? username = null,Object? email = null,Object? phone = null,Object? nik = null,Object? avatarPath = null,Object? isCustomAvatar = null,Object? avatarBgColor = null,Object? initials = null,}) {
  return _then(_self.copyWith(
nama: null == nama ? _self.nama : nama // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,nik: null == nik ? _self.nik : nik // ignore: cast_nullable_to_non_nullable
as String,avatarPath: null == avatarPath ? _self.avatarPath : avatarPath // ignore: cast_nullable_to_non_nullable
as String,isCustomAvatar: null == isCustomAvatar ? _self.isCustomAvatar : isCustomAvatar // ignore: cast_nullable_to_non_nullable
as bool,avatarBgColor: null == avatarBgColor ? _self.avatarBgColor : avatarBgColor // ignore: cast_nullable_to_non_nullable
as Color,initials: null == initials ? _self.initials : initials // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String nama,  String username,  String email,  String phone,  String nik,  String avatarPath,  bool isCustomAvatar, @ColorConverter()  Color avatarBgColor,  String initials)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.nama,_that.username,_that.email,_that.phone,_that.nik,_that.avatarPath,_that.isCustomAvatar,_that.avatarBgColor,_that.initials);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String nama,  String username,  String email,  String phone,  String nik,  String avatarPath,  bool isCustomAvatar, @ColorConverter()  Color avatarBgColor,  String initials)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.nama,_that.username,_that.email,_that.phone,_that.nik,_that.avatarPath,_that.isCustomAvatar,_that.avatarBgColor,_that.initials);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String nama,  String username,  String email,  String phone,  String nik,  String avatarPath,  bool isCustomAvatar, @ColorConverter()  Color avatarBgColor,  String initials)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.nama,_that.username,_that.email,_that.phone,_that.nik,_that.avatarPath,_that.isCustomAvatar,_that.avatarBgColor,_that.initials);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfile extends UserProfile {
  const _UserProfile({this.nama = 'Pengguna Hondaku', this.username = '', this.email = '', this.phone = '-', this.nik = '-', this.avatarPath = 'assets/images/profile.png', this.isCustomAvatar = true, @ColorConverter() required this.avatarBgColor, required this.initials}): super._();
  factory _UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

@override@JsonKey() final  String nama;
@override@JsonKey() final  String username;
@override@JsonKey() final  String email;
@override@JsonKey() final  String phone;
@override@JsonKey() final  String nik;
@override@JsonKey() final  String avatarPath;
@override@JsonKey() final  bool isCustomAvatar;
@override@ColorConverter() final  Color avatarBgColor;
@override final  String initials;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.nama, nama) || other.nama == nama)&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.nik, nik) || other.nik == nik)&&(identical(other.avatarPath, avatarPath) || other.avatarPath == avatarPath)&&(identical(other.isCustomAvatar, isCustomAvatar) || other.isCustomAvatar == isCustomAvatar)&&(identical(other.avatarBgColor, avatarBgColor) || other.avatarBgColor == avatarBgColor)&&(identical(other.initials, initials) || other.initials == initials));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nama,username,email,phone,nik,avatarPath,isCustomAvatar,avatarBgColor,initials);

@override
String toString() {
  return 'UserProfile(nama: $nama, username: $username, email: $email, phone: $phone, nik: $nik, avatarPath: $avatarPath, isCustomAvatar: $isCustomAvatar, avatarBgColor: $avatarBgColor, initials: $initials)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 String nama, String username, String email, String phone, String nik, String avatarPath, bool isCustomAvatar,@ColorConverter() Color avatarBgColor, String initials
});




}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nama = null,Object? username = null,Object? email = null,Object? phone = null,Object? nik = null,Object? avatarPath = null,Object? isCustomAvatar = null,Object? avatarBgColor = null,Object? initials = null,}) {
  return _then(_UserProfile(
nama: null == nama ? _self.nama : nama // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,nik: null == nik ? _self.nik : nik // ignore: cast_nullable_to_non_nullable
as String,avatarPath: null == avatarPath ? _self.avatarPath : avatarPath // ignore: cast_nullable_to_non_nullable
as String,isCustomAvatar: null == isCustomAvatar ? _self.isCustomAvatar : isCustomAvatar // ignore: cast_nullable_to_non_nullable
as bool,avatarBgColor: null == avatarBgColor ? _self.avatarBgColor : avatarBgColor // ignore: cast_nullable_to_non_nullable
as Color,initials: null == initials ? _self.initials : initials // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
