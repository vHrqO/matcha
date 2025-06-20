import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/ui/widgets/shared/tabs_item/tab_tile.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/tabs_item_list_section/session_hovermenu.dart';
import 'package:matcha/view_model/shared/selected_viewmodel.dart';

class SessionTabTile extends ConsumerStatefulWidget {
  const SessionTabTile({super.key, required this.tab, required this.hoverMenu});

  final matcha_tab.Tab tab;

  final Widget hoverMenu;

  @override
  ConsumerState<SessionTabTile> createState() => _SessionTabTileState();
}

class _SessionTabTileState extends ConsumerState<SessionTabTile> {
  @override
  Widget build(BuildContext context) {
    ref.watch(selectedTabsItemProvider);
    final isSelected = ref
        .read(selectedTabsItemProvider.notifier)
        .isSelected(widget.tab);

    return TabTile(
      tab: widget.tab,
      hoverMenu: widget.hoverMenu,
      isSelected: isSelected,
      onChanged: (value) {
        if (value == true) {
          ref
              .read(selectedTabsItemProvider.notifier)
              .addSelected(widget.tab);
        } else {
          ref.read(selectedTabsItemProvider.notifier).removeSelected(widget.tab);
        }
      },
    );
  }
}
