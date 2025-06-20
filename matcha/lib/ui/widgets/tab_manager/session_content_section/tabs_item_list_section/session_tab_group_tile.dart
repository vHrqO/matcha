import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;
import 'package:matcha/ui/widgets/shared/tabs_item/tab_group_tile.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/tabs_item_list_section/session_hovermenu.dart';
import 'package:matcha/view_model/shared/selected_viewmodel.dart';

class SessionTabGroupTile extends ConsumerStatefulWidget {
  const SessionTabGroupTile({super.key, required this.tabGroup, required this.hoverMenu});

  final matcha_tab_group.TabGroup tabGroup;

  final Widget hoverMenu;

  @override
  ConsumerState<SessionTabGroupTile> createState() => _SessionTabGroupTileState();
}

class _SessionTabGroupTileState extends ConsumerState<SessionTabGroupTile> {
  @override
  Widget build(BuildContext context) {
    ref.watch(selectedTabsItemProvider);
    final isSelected = ref
        .read(selectedTabsItemProvider.notifier)
        .isSelected(widget.tabGroup);

    return TabGroupTile(
      tabGroup: widget.tabGroup,
      hoverMenu: widget.hoverMenu,
      isSelected: isSelected,
      onChanged: (value) {
        if (value == true) {
          ref
              .read(selectedTabsItemProvider.notifier)
              .addSelected(widget.tabGroup);
        } else {
          ref
              .read(selectedTabsItemProvider.notifier)
              .removeSelected(widget.tabGroup);
        }
      },
    );
  }
}
