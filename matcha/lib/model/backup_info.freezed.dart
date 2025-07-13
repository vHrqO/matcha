// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BackupInfo {

//
 String get name;//
 set name(String value); String get backupType; set backupType(String value); DateTime get saveTime; set saveTime(DateTime value);
/// Create a copy of BackupInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupInfoCopyWith<BackupInfo> get copyWith => _$BackupInfoCopyWithImpl<BackupInfo>(this as BackupInfo, _$identity);

  /// Serializes this BackupInfo to a JSON map.
  Map<String, dynamic> toJson();




@override
String toString() {
  return 'BackupInfo(name: $name, backupType: $backupType, saveTime: $saveTime)';
}


}

/// @nodoc
abstract mixin class $BackupInfoCopyWith<$Res>  {
  factory $BackupInfoCopyWith(BackupInfo value, $Res Function(BackupInfo) _then) = _$BackupInfoCopyWithImpl;
@useResult
$Res call({
 String name, String backupType, DateTime saveTime
});




}
/// @nodoc
class _$BackupInfoCopyWithImpl<$Res>
    implements $BackupInfoCopyWith<$Res> {
  _$BackupInfoCopyWithImpl(this._self, this._then);

  final BackupInfo _self;
  final $Res Function(BackupInfo) _then;

/// Create a copy of BackupInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? backupType = null,Object? saveTime = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,backupType: null == backupType ? _self.backupType : backupType // ignore: cast_nullable_to_non_nullable
as String,saveTime: null == saveTime ? _self.saveTime : saveTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [BackupInfo].
extension BackupInfoPatterns on BackupInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupInfo value)  $default,){
final _that = this;
switch (_that) {
case _BackupInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupInfo value)?  $default,){
final _that = this;
switch (_that) {
case _BackupInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String backupType,  DateTime saveTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupInfo() when $default != null:
return $default(_that.name,_that.backupType,_that.saveTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String backupType,  DateTime saveTime)  $default,) {final _that = this;
switch (_that) {
case _BackupInfo():
return $default(_that.name,_that.backupType,_that.saveTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String backupType,  DateTime saveTime)?  $default,) {final _that = this;
switch (_that) {
case _BackupInfo() when $default != null:
return $default(_that.name,_that.backupType,_that.saveTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BackupInfo implements BackupInfo {
   _BackupInfo({required this.name, required this.backupType, required this.saveTime});
  factory _BackupInfo.fromJson(Map<String, dynamic> json) => _$BackupInfoFromJson(json);

//
@override  String name;
@override  String backupType;
@override  DateTime saveTime;

/// Create a copy of BackupInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackupInfoCopyWith<_BackupInfo> get copyWith => __$BackupInfoCopyWithImpl<_BackupInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BackupInfoToJson(this, );
}



@override
String toString() {
  return 'BackupInfo(name: $name, backupType: $backupType, saveTime: $saveTime)';
}


}

/// @nodoc
abstract mixin class _$BackupInfoCopyWith<$Res> implements $BackupInfoCopyWith<$Res> {
  factory _$BackupInfoCopyWith(_BackupInfo value, $Res Function(_BackupInfo) _then) = __$BackupInfoCopyWithImpl;
@override @useResult
$Res call({
 String name, String backupType, DateTime saveTime
});




}
/// @nodoc
class __$BackupInfoCopyWithImpl<$Res>
    implements _$BackupInfoCopyWith<$Res> {
  __$BackupInfoCopyWithImpl(this._self, this._then);

  final _BackupInfo _self;
  final $Res Function(_BackupInfo) _then;

/// Create a copy of BackupInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? backupType = null,Object? saveTime = null,}) {
  return _then(_BackupInfo(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,backupType: null == backupType ? _self.backupType : backupType // ignore: cast_nullable_to_non_nullable
as String,saveTime: null == saveTime ? _self.saveTime : saveTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
