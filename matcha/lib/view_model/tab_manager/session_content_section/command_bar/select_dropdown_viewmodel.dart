import 'package:matcha/model/session/session.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/view_model/tab_manager/session_content_section/session_content_viewmodel.dart';
import 'package:matcha/view_model/shared/selected_viewmodel.dart';

part 'select_dropdown_viewmodel.g.dart';

@riverpod
class SelectDropdown extends _$SelectDropdown {
  bool _enabled = false;

  late Session _selectedSession;

  @override
  Future<bool> build() async {
    final selectedSession = await ref.watch(selectedSessionProvider.future);
    if (selectedSession == null) {
      _enabled = false;
      return _enabled;
    }

    _selectedSession = selectedSession;
    _enabled = true;

    return _enabled;
  }

  Future<void> selectAll() async {
    if (!_enabled) {
      throw Exception('SelectDropdown is not enabled');
    }

    for (final tabsItem in _selectedSession.tabsItemList) {
      ref.read(selectedTabsItemProvider.notifier).addSelected(tabsItem);
    }
  }

  Future<void> invertSelection() async {
    if (!_enabled) {
      throw Exception('SelectDropdown is not enabled');
    }

    final allTabsItems = _selectedSession.tabsItemList;

    for (final tabsItem in allTabsItems) {
      if (!ref.read(selectedTabsItemProvider.notifier).isSelected(tabsItem)) {
        ref.read(selectedTabsItemProvider.notifier).addSelected(tabsItem);
      } else {
        ref.read(selectedTabsItemProvider.notifier).removeSelected(tabsItem);
      }
    }
  }

  void clearSelection() {
    if (!_enabled) {
      throw Exception('SelectDropdown is not enabled');
    }

    ref.read(selectedTabsItemProvider.notifier).clearSelected();
  }
}
