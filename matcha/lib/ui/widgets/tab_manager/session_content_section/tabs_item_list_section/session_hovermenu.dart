import 'package:flutter/material.dart';

import 'package:matcha/ui/widgets/tab_manager/session_content_section/command_bar/delete_button.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/command_bar/edit_button.dart';
import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;
import 'package:matcha/ui/widgets/tab_manager/session_content_section/command_bar/move_group_button.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/command_bar/open_button.dart';

// for tab tile
class TabHoverMenu extends StatefulWidget {
  const TabHoverMenu({super.key, required this.tab});

  final matcha_tab.Tab tab;

  @override
  State<TabHoverMenu> createState() => _TabHoverMenuState();
}

class _TabHoverMenuState extends State<TabHoverMenu> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Tooltip(message: 'Move to Group', child: MoveToGroupButtonTapRx(widget.tab)),

        Tooltip(
          message: 'Open',
          child: OpenButton(tabsItem: widget.tab),
        ),

        Tooltip(
          message: 'Edit',
          child: EditButtonTapRx(tabsItem: widget.tab),
        ),

        Tooltip(
          message: 'Delete',
          child: DeleteButtonTapRx(tabsItem: widget.tab),
        ),
      ],
    );
  }
}

// for tab group tile
class TabGroupHoverMenu extends StatefulWidget {
  const TabGroupHoverMenu({super.key, required this.tabGroup});

  final matcha_tab_group.TabGroup tabGroup;

  @override
  State<TabGroupHoverMenu> createState() => _TabGroupHoverMenuState();
}

class _TabGroupHoverMenuState extends State<TabGroupHoverMenu> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Tooltip(
          message: 'Open',
          child: OpenButton(tabsItem: widget.tabGroup),
        ),

        Tooltip(
          message: 'Edit',
          child: EditButtonTapRx(tabsItem: widget.tabGroup),
        ),

        Tooltip(
          message: 'Delete',
          child: DeleteButtonTapRx(tabsItem: widget.tabGroup),
        ),
      ],
    );
  }
}

// for tab group section - tab tile
class SectionTabHoverMenu extends StatefulWidget {
  const SectionTabHoverMenu({super.key, required this.tab});

  final matcha_tab.Tab tab;

  @override
  State<SectionTabHoverMenu> createState() => _SectionTabHoverMenuState();
}

class _SectionTabHoverMenuState extends State<SectionTabHoverMenu> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Tooltip(
          message: 'Move out of Group',
          child: MoveOutGroupButtonTapRx(widget.tab),
        ),

        Tooltip(
          message: 'Open',
          child: OpenButton(tabsItem: widget.tab),
        ),

        Tooltip(
          message: 'Edit',
          child: EditButtonTapRx(tabsItem: widget.tab),
        ),

        Tooltip(
          message: 'Delete',
          child: DeleteButtonTapRx(tabsItem: widget.tab),
        ),
      ],
    );
  }
}
