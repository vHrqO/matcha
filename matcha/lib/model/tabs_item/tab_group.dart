import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:matcha/model/tabs_item/tabs_item.dart';
import 'package:matcha/model/tabs_item/tab.dart';

part 'tab_group.freezed.dart';
part 'tab_group.g.dart';

@unfreezed
abstract class TabGroup with _$TabGroup implements TabsItem {
  factory TabGroup({
    required int id,
    required TabsItemType type,

    required String title,

    required List<Tab> tabList,

    @Default([]) //
    List<String> tagList,
  }) = _TabGroup;

  factory TabGroup.fromJson(Map<String, Object?> json) => _$TabGroupFromJson(json);
}
