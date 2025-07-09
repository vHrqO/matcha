// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tab_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TabGroup {

 int get id; set id(int value); TabsItemType get type; set type(TabsItemType value); String get title; set title(String value); List<Tab> get tabList; set tabList(List<Tab> value); List<String> get tagList; set tagList(List<String> value);
/// Create a copy of TabGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TabGroupCopyWith<TabGroup> get copyWith => _$TabGroupCopyWithImpl<TabGroup>(this as TabGroup, _$identity);

  /// Serializes this TabGroup to a JSON map.
  Map<String, dynamic> toJson();




@override
String toString() {
  return 'TabGroup(id: $id, type: $type, title: $title, tabList: $tabList, tagList: $tagList)';
}


}

/// @nodoc
abstract mixin class $TabGroupCopyWith<$Res>  {
  factory $TabGroupCopyWith(TabGroup value, $Res Function(TabGroup) _then) = _$TabGroupCopyWithImpl;
@useResult
$Res call({
 int id, TabsItemType type, String title, List<Tab> tabList, List<String> tagList
});




}
/// @nodoc
class _$TabGroupCopyWithImpl<$Res>
    implements $TabGroupCopyWith<$Res> {
  _$TabGroupCopyWithImpl(this._self, this._then);

  final TabGroup _self;
  final $Res Function(TabGroup) _then;

/// Create a copy of TabGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? title = null,Object? tabList = null,Object? tagList = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TabsItemType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,tabList: null == tabList ? _self.tabList : tabList // ignore: cast_nullable_to_non_nullable
as List<Tab>,tagList: null == tagList ? _self.tagList : tagList // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [TabGroup].
extension TabGroupPatterns on TabGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TabGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TabGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TabGroup value)  $default,){
final _that = this;
switch (_that) {
case _TabGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TabGroup value)?  $default,){
final _that = this;
switch (_that) {
case _TabGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  TabsItemType type,  String title,  List<Tab> tabList,  List<String> tagList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TabGroup() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.tabList,_that.tagList);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  TabsItemType type,  String title,  List<Tab> tabList,  List<String> tagList)  $default,) {final _that = this;
switch (_that) {
case _TabGroup():
return $default(_that.id,_that.type,_that.title,_that.tabList,_that.tagList);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  TabsItemType type,  String title,  List<Tab> tabList,  List<String> tagList)?  $default,) {final _that = this;
switch (_that) {
case _TabGroup() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.tabList,_that.tagList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TabGroup implements TabGroup {
   _TabGroup({required this.id, required this.type, required this.title, required this.tabList, this.tagList = const []});
  factory _TabGroup.fromJson(Map<String, dynamic> json) => _$TabGroupFromJson(json);

@override  int id;
@override  TabsItemType type;
@override  String title;
@override  List<Tab> tabList;
@override@JsonKey()  List<String> tagList;

/// Create a copy of TabGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TabGroupCopyWith<_TabGroup> get copyWith => __$TabGroupCopyWithImpl<_TabGroup>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TabGroupToJson(this, );
}



@override
String toString() {
  return 'TabGroup(id: $id, type: $type, title: $title, tabList: $tabList, tagList: $tagList)';
}


}

/// @nodoc
abstract mixin class _$TabGroupCopyWith<$Res> implements $TabGroupCopyWith<$Res> {
  factory _$TabGroupCopyWith(_TabGroup value, $Res Function(_TabGroup) _then) = __$TabGroupCopyWithImpl;
@override @useResult
$Res call({
 int id, TabsItemType type, String title, List<Tab> tabList, List<String> tagList
});




}
/// @nodoc
class __$TabGroupCopyWithImpl<$Res>
    implements _$TabGroupCopyWith<$Res> {
  __$TabGroupCopyWithImpl(this._self, this._then);

  final _TabGroup _self;
  final $Res Function(_TabGroup) _then;

/// Create a copy of TabGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? title = null,Object? tabList = null,Object? tagList = null,}) {
  return _then(_TabGroup(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TabsItemType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,tabList: null == tabList ? _self.tabList : tabList // ignore: cast_nullable_to_non_nullable
as List<Tab>,tagList: null == tagList ? _self.tagList : tagList // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
