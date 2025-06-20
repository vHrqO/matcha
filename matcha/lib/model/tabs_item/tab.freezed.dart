// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tab.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Tab {

 int get id; set id(int value); int? get groupId; set groupId(int? value); TabsItemType get type; set type(TabsItemType value); String get title; set title(String value); String get url; set url(String value); List<String> get tagList; set tagList(List<String> value);
/// Create a copy of Tab
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TabCopyWith<Tab> get copyWith => _$TabCopyWithImpl<Tab>(this as Tab, _$identity);

  /// Serializes this Tab to a JSON map.
  Map<String, dynamic> toJson();




@override
String toString() {
  return 'Tab(id: $id, groupId: $groupId, type: $type, title: $title, url: $url, tagList: $tagList)';
}


}

/// @nodoc
abstract mixin class $TabCopyWith<$Res>  {
  factory $TabCopyWith(Tab value, $Res Function(Tab) _then) = _$TabCopyWithImpl;
@useResult
$Res call({
 int id, int? groupId, TabsItemType type, String title, String url, List<String> tagList
});




}
/// @nodoc
class _$TabCopyWithImpl<$Res>
    implements $TabCopyWith<$Res> {
  _$TabCopyWithImpl(this._self, this._then);

  final Tab _self;
  final $Res Function(Tab) _then;

/// Create a copy of Tab
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? groupId = freezed,Object? type = null,Object? title = null,Object? url = null,Object? tagList = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TabsItemType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,tagList: null == tagList ? _self.tagList : tagList // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Tab implements Tab {
   _Tab({required this.id, this.groupId, required this.type, required this.title, required this.url, this.tagList = const []});
  factory _Tab.fromJson(Map<String, dynamic> json) => _$TabFromJson(json);

@override  int id;
@override  int? groupId;
@override  TabsItemType type;
@override  String title;
@override  String url;
@override@JsonKey()  List<String> tagList;

/// Create a copy of Tab
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TabCopyWith<_Tab> get copyWith => __$TabCopyWithImpl<_Tab>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TabToJson(this, );
}



@override
String toString() {
  return 'Tab(id: $id, groupId: $groupId, type: $type, title: $title, url: $url, tagList: $tagList)';
}


}

/// @nodoc
abstract mixin class _$TabCopyWith<$Res> implements $TabCopyWith<$Res> {
  factory _$TabCopyWith(_Tab value, $Res Function(_Tab) _then) = __$TabCopyWithImpl;
@override @useResult
$Res call({
 int id, int? groupId, TabsItemType type, String title, String url, List<String> tagList
});




}
/// @nodoc
class __$TabCopyWithImpl<$Res>
    implements _$TabCopyWith<$Res> {
  __$TabCopyWithImpl(this._self, this._then);

  final _Tab _self;
  final $Res Function(_Tab) _then;

/// Create a copy of Tab
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? groupId = freezed,Object? type = null,Object? title = null,Object? url = null,Object? tagList = null,}) {
  return _then(_Tab(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TabsItemType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,tagList: null == tagList ? _self.tagList : tagList // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
