import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:matcha/model/tabs_item/tabs_item.dart';

part 'session.freezed.dart';

@unfreezed
abstract class Session with _$Session {
  factory Session({
    required int id,

    required String name,

    required List<TabsItem> tabsItemList,
  }) = _Session;
}
