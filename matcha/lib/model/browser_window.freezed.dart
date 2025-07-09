// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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


/// Adds pattern-matching-related methods to [BrowserWindow].
extension BrowserWindowPatterns on BrowserWindow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BrowserWindow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BrowserWindow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BrowserWindow value)  $default,){
final _that = this;
switch (_that) {
case _BrowserWindow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BrowserWindow value)?  $default,){
final _that = this;
switch (_that) {
case _BrowserWindow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  List<TabsItem> tabsItemList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BrowserWindow() when $default != null:
return $default(_that.id,_that.tabsItemList);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  List<TabsItem> tabsItemList)  $default,) {final _that = this;
switch (_that) {
case _BrowserWindow():
return $default(_that.id,_that.tabsItemList);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  List<TabsItem> tabsItemList)?  $default,) {final _that = this;
switch (_that) {
case _BrowserWindow() when $default != null:
return $default(_that.id,_that.tabsItemList);case _:
  return null;

}
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
