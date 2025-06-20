// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionMeta {

//
 int get id;//
 set id(int value); String get name; set name(String value);
/// Create a copy of SessionMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionMetaCopyWith<SessionMeta> get copyWith => _$SessionMetaCopyWithImpl<SessionMeta>(this as SessionMeta, _$identity);





@override
String toString() {
  return 'SessionMeta(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $SessionMetaCopyWith<$Res>  {
  factory $SessionMetaCopyWith(SessionMeta value, $Res Function(SessionMeta) _then) = _$SessionMetaCopyWithImpl;
@useResult
$Res call({
 int id, String name
});




}
/// @nodoc
class _$SessionMetaCopyWithImpl<$Res>
    implements $SessionMetaCopyWith<$Res> {
  _$SessionMetaCopyWithImpl(this._self, this._then);

  final SessionMeta _self;
  final $Res Function(SessionMeta) _then;

/// Create a copy of SessionMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _SessionMeta implements SessionMeta {
   _SessionMeta({required this.id, required this.name});
  

//
@override  int id;
@override  String name;

/// Create a copy of SessionMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionMetaCopyWith<_SessionMeta> get copyWith => __$SessionMetaCopyWithImpl<_SessionMeta>(this, _$identity);





@override
String toString() {
  return 'SessionMeta(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$SessionMetaCopyWith<$Res> implements $SessionMetaCopyWith<$Res> {
  factory _$SessionMetaCopyWith(_SessionMeta value, $Res Function(_SessionMeta) _then) = __$SessionMetaCopyWithImpl;
@override @useResult
$Res call({
 int id, String name
});




}
/// @nodoc
class __$SessionMetaCopyWithImpl<$Res>
    implements _$SessionMetaCopyWith<$Res> {
  __$SessionMetaCopyWithImpl(this._self, this._then);

  final _SessionMeta _self;
  final $Res Function(_SessionMeta) _then;

/// Create a copy of SessionMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_SessionMeta(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
