import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:matcha/app/constants.dart' as constants;
import 'package:matcha/mock_data/session.dart';
import 'package:matcha/model/session/session.dart';
import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;
import 'package:matcha/model/tabs_item/tabs_item.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/tabs_item_list_section/session_tab_group_tile.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/tabs_item_list_section/session_tab_tile.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/session_content_viewmodel.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/tabs_item_list_section/session_hovermenu.dart'
    as session_hovermenu;

class TabsItemListRx extends ConsumerWidget {
  const TabsItemListRx({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortedSelectedSessionAsync = ref.watch(sortedSelectedSessionProvider);

    switch (sortedSelectedSessionAsync) {
      case AsyncData(value: final Session session):
      case AsyncLoading(value: final Session session):
        return TabsItemList(tabsItemList: session.tabsItemList);

      case AsyncError(error: final error, stackTrace: final stackTrace):
        // to_do: use notification
        return Text('Oops, something unexpected happened: $error');

      default:
        return Skeletonizer(
          child: TabsItemList(tabsItemList: mockSession.tabsItemList),
        );
    }
  }
}

class TabsItemList extends ConsumerStatefulWidget {
  const TabsItemList({super.key, required this.tabsItemList});

  final List<TabsItem> tabsItemList;

  @override
  ConsumerState<TabsItemList> createState() => _TabsItemListWidgetState();
}

class _TabsItemListWidgetState extends ConsumerState<TabsItemList> {
  @override
  Widget build(BuildContext context) {
    final tabsItemListSortOrder = ref.watch(tabsItemListSortOrderProvider);

    return Card(
      child: ReorderableListView.builder(
        buildDefaultDragHandles: false,
        itemCount: widget.tabsItemList.length,
        itemBuilder: (context, index) {
          final TabsItem tabsItem = widget.tabsItemList[index];

          if (tabsItem is matcha_tab.Tab) {
            matcha_tab.Tab tab = tabsItem;

            return ReorderableDelayedDragStartListener(
              key: ObjectKey(tab),
              index: index,
              enabled: tabsItemListSortOrder == constants.SortOrder.custom,
              child: SessionTabTile(
                tab: tab,
                hoverMenu: session_hovermenu.TabHoverMenu(tab: tab),
              ),
            );
          }

          if (tabsItem is matcha_tab_group.TabGroup) {
            matcha_tab_group.TabGroup tabGroup = tabsItem;

            return ReorderableDelayedDragStartListener(
              key: ObjectKey(tabGroup),
              index: index,
              enabled: tabsItemListSortOrder == constants.SortOrder.custom,
              child: SessionTabGroupTile(
                tabGroup: tabGroup,
                hoverMenu: session_hovermenu.TabGroupHoverMenu(tabGroup: tabGroup),
              ),
            );
          }

          throw ArgumentError('Unknown TabsItem type: ${tabsItem.runtimeType}');
        },

        onReorder: (int oldIndex, int newIndex) async {
          int oldId = -1;
          int newId = -1;

          setState(() {
            // The newIndex provided by Flutter is the index after the target item.
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            oldId = widget.tabsItemList[oldIndex].id;
            newId = widget.tabsItemList[newIndex].id;

            final item = widget.tabsItemList.removeAt(oldIndex);
            widget.tabsItemList.insert(newIndex, item);
          });

          await ref
              .read(sessionContentOrderProvider.notifier)
              .reorder(oldIndex, newIndex, oldId, newId);
        },
      ),
    );
  }
}
