// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'browser_window.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BrowserWindow {

//
 int get id;//
 set id(int value); List<TabsItem> get tabsItemList; set tabsItemList(List<TabsItem> value);
/// Create a copy of BrowserWindow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BrowserWindowCopyWith<BrowserWindow> get copyWith => _$BrowserWindowCopyWithImpl<BrowserWindow>(this as BrowserWindow, _$identity);





@override
String toString() {
  return 'BrowserWindow(id: $id, tabsItemList: $tabsItemList)';
}


}

/// @nodoc
abstract mixin class $BrowserWindowCopyWith<$Res>  {
  factory $BrowserWindowCopyWith(BrowserWindow value, $Res Function(BrowserWindow) _then) = _$BrowserWindowCopyWithImpl;
@useResult
$Res call({
 int id, List<TabsItem> tabsItemList
});




}
/// @nodoc
class _$BrowserWindowCopyWithImpl<$Res>
    implements $BrowserWindowCopyWith<$Res> {
  _$BrowserWindowCopyWithImpl(this._self, this._then);

  final BrowserWindow _self;
  final $Res Function(BrowserWindow) _then;

/// Create a copy of BrowserWindow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tabsItemList = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,tabsItemList: null == tabsItemList ? _self.tabsItemList : tabsItemList // ignore: cast_nullable_to_non_nullable
as List<TabsItem>,
  ));
}

}


/// @nodoc


class _BrowserWindow implements BrowserWindow {
   _BrowserWindow({required this.id, required this.tabsItemList});
  

//
@override  int id;
@override  List<TabsItem> tabsItemList;

/// Create a copy of BrowserWindow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BrowserWindowCopyWith<_BrowserWindow> get copyWith => __$BrowserWindowCopyWithImpl<_BrowserWindow>(this, _$identity);





@override
String toString() {
  return 'BrowserWindow(id: $id, tabsItemList: $tabsItemList)';
}


}

/// @nodoc
abstract mixin class _$BrowserWindowCopyWith<$Res> implements $BrowserWindowCopyWith<$Res> {
  factory _$BrowserWindowCopyWith(_BrowserWindow value, $Res Function(_BrowserWindow) _then) = __$BrowserWindowCopyWithImpl;
@override @useResult
$Res call({
 int id, List<TabsItem> tabsItemList
});




}
/// @nodoc
class __$BrowserWindowCopyWithImpl<$Res>
    implements _$BrowserWindowCopyWith<$Res> {
  __$BrowserWindowCopyWithImpl(this._self, this._then);

  final _BrowserWindow _self;
  final $Res Function(_BrowserWindow) _then;

/// Create a copy of BrowserWindow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tabsItemList = null,}) {
  return _then(_BrowserWindow(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,tabsItemList: null == tabsItemList ? _self.tabsItemList : tabsItemList // ignore: cast_nullable_to_non_nullable
as List<TabsItem>,
  ));
}


}

// dart format on
