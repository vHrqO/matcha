import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/model/tabs_item/tabs_item.dart';
import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;
import 'package:matcha/view_model/shared/selected_viewmodel.dart';

part 'open_button_viewmodel.g.dart';

@riverpod
class OpenButton extends _$OpenButton {
  bool _enabled = false;

  int _tabCount = 0;
  int _tabGroupCount = 0;

  bool _appTypeOnly = false;

  @override
  bool build() {
    ref.watch(selectedTabsItemProvider);

    _appTypeOnly = ref.read(selectedTabsItemProvider.notifier).isAppTypeOnly();

    _tabCount = ref.read(selectedTabsItemProvider.notifier).getTabCount();
    _tabGroupCount = ref.read(selectedTabsItemProvider.notifier).getTabGroupCount();

    // only when app type is selected
    if (!_appTypeOnly) {
      _enabled = false;
      return _enabled;
    }

    // has tabsitem
    _enabled = (_tabCount + _tabGroupCount) > 0;

    return _enabled;
  }

  void open() {
    if (!_enabled) {
      throw Exception('GroupButton is not enabled');
    }

    List<matcha_tab.Tab> toOpenTabs = [];

    final selectedTabs = ref.read(selectedTabsItemProvider);

    selectedTabs.values.map((item) {
      if (item is matcha_tab.Tab) {
        toOpenTabs.add(item);
      } else if (item is matcha_tab_group.TabGroup) {
        toOpenTabs.addAll(item.tabList);
      }
    }).toList();

    ref.read(selectedTabsItemProvider.notifier).clearSelected();

    // service api - open tab in browser
    for (final item in toOpenTabs) {
      print("title: ${item.title}, url: ${item.url}");
    }
  }
}


void openButtonTap(TabsItem tabsItem) {
  if (tabsItem is matcha_tab.Tab) {
    // service api - open tab in browser
    print("title: ${tabsItem.title}, url: ${tabsItem.url}");
  } else if (tabsItem is matcha_tab_group.TabGroup) {
    // service api - open tab in browser
    for (final tab in tabsItem.tabList) {
      print("title: ${tab.title}, url: ${tab.url}");
    }
  }
}
