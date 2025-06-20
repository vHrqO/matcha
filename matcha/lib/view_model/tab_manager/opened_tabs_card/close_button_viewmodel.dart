import 'package:matcha/view_model/tab_manager/opened_tabs_card/opened_tabs_card_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/model/tabs_item/tabs_item.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/session_content_viewmodel.dart';
import 'package:matcha/view_model/shared/selected_viewmodel.dart';

part 'close_button_viewmodel.g.dart';

@riverpod
class CloseButton extends _$CloseButton {
  bool _enabled = false;

  int? _selectedSessionId;
  int? _selectedWindowId;

  @override
  Future<bool> build() async {
    final selectedWindowId = await ref.watch(selectedWindowIdProvider.future);

    final selectedSessionId = await ref.watch(selectedSessionIdProvider.future);

    if ((selectedWindowId == null) || (selectedSessionId == null)) {
      _enabled = false;
      return _enabled;
    }

    _selectedWindowId = selectedWindowId;
    _selectedSessionId = selectedSessionId;

    _enabled = true;

    return _enabled;
  }

  Future<void> close(TabsItem tabsItem) async {
    if (!_enabled) {
      throw Exception('CloseButton is not enabled');
    }

    await ref
        .read(windowProvider(_selectedWindowId!).notifier)
        .removeTabsItem(tabsItem);

    ref.read(selectedTabsItemProvider.notifier).clearSelected();
  }
}
