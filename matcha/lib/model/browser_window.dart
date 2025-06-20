import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:matcha/model/tabs_item/tabs_item.dart';

part 'browser_window.freezed.dart';

@unfreezed
abstract class BrowserWindow with _$BrowserWindow {
  factory BrowserWindow({
    //
    required int id,

    required List<TabsItem> tabsItemList,
  }) = _BrowserWindow;
}
