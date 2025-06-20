import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:matcha/model/tabs_item/tabs_item.dart';

part 'tab.freezed.dart';
part 'tab.g.dart';

@unfreezed
abstract class Tab with _$Tab implements TabsItem {
  factory Tab({
    required int id,
    int? groupId,
    required TabsItemType type,

    required String title,
    required String url,

    @Default([]) //
    List<String> tagList,
  }) = _Tab;

  factory Tab.fromJson(Map<String, Object?> json) => _$TabFromJson(json);
}
