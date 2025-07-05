import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;
import 'package:matcha/ui/widgets/tab_manager/session_content_section/tabs_item_list_section/session_tab_tile.dart';
import 'package:matcha/view_model/shared/app_viewmodel.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/session_content_viewmodel.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TabGroupCard extends StatelessWidget {
  const TabGroupCard({
    super.key,
    required this.tabGroup,
    required this.hoverMenuBuilder,
  });

  final matcha_tab_group.TabGroup tabGroup;

  final Widget Function(matcha_tab.Tab tab) hoverMenuBuilder;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TitleBar(title: tabGroup.title),
            ),

            Divider(),

            Expanded(
              child: Skeleton.replace(
                replacement: Column(
                  children: [
                    ListTile(title: Text("Tab example 1")),
                    ListTile(title: Text("Tab example 2")),
                  ],
                ),

                child: TabList(
                  tabList: tabGroup.tabList,
                  hoverMenuBuilder: hoverMenuBuilder,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleBar extends ConsumerWidget {
  const TitleBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Icon(FluentIcons.app_folder_20_regular),
        const SizedBox(width: 8.0),
        Text(title),

        Spacer(),

        Skeleton.keep(
          child: Tooltip(
            message: "Close",
            child: IconButton(
              padding: const EdgeInsets.all(0.0),
              icon: const Icon(Icons.close),
              onPressed: () {
                ref.read(tabGroupOpenedProvider.notifier).toggle(false);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class TabList extends ConsumerStatefulWidget {
  const TabList({super.key, required this.tabList, required this.hoverMenuBuilder});

  final List<matcha_tab.Tab> tabList;

  final Widget Function(matcha_tab.Tab tab) hoverMenuBuilder;

  @override
  ConsumerState<TabList> createState() => _TabListState();
}

class _TabListState extends ConsumerState<TabList> {
  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      buildDefaultDragHandles: false,
      itemCount: widget.tabList.length,
      itemBuilder: (context, index) {
        return ReorderableDelayedDragStartListener(
          key: ObjectKey(widget.tabList[index]),
          index: index,
          child: SessionTabTile(
            tab: widget.tabList[index],
            hoverMenu: widget.hoverMenuBuilder(widget.tabList[index]),
          ),
        );
      },

      onReorder: (int oldIndex, int newIndex) async {
        int oldId = -1;
        int newId = -1;

        setState(() {
          // The newIndex provided by Flutter is the index after the target item.
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          oldId = widget.tabList[oldIndex].id;
          newId = widget.tabList[newIndex].id;

          final item = widget.tabList.removeAt(oldIndex);
          widget.tabList.insert(newIndex, item);
        });

        await ref
            .read(sessionContentOrderProvider.notifier)
            .reorderInGroup(oldIndex, newIndex, oldId, newId);
      },
    );
  }
}
