import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;
import 'package:matcha/view_model/tab_manager/session_content_section/edit_tabs_item_dialog_viewmodel.dart';

class TabTitleTile extends ConsumerStatefulWidget {
  const TabTitleTile({super.key, required this.sessionId, this.tab});

  final int sessionId;

  // null as add
  final matcha_tab.Tab? tab;

  @override
  ConsumerState<TabTitleTile> createState() => _TabTitleTileState();
}

class _TabTitleTileState extends ConsumerState<TabTitleTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(FluentIcons.text_case_title_24_regular),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: const Text('Tab Title'),
      ),
      subtitle: TextFormField(
        decoration: InputDecoration(border: OutlineInputBorder()),

        initialValue: widget.tab?.title,
        autovalidateMode: AutovalidateMode.always,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a tab title';
          }

          return null;
        },
        onChanged: (value) {
          ref
              .read(
                editTabFormProvider(
                  sessionId: widget.sessionId,
                  tab: widget.tab,
                ).notifier,
              )
              .setTitle(value);
        },
      ),
    );
  }
}

class TabGroupTitleTile extends ConsumerStatefulWidget {
  const TabGroupTitleTile({super.key, required this.sessionId, this.tabGroup});

  final int sessionId;

  // null as add
  final matcha_tab_group.TabGroup? tabGroup;

  @override
  ConsumerState<TabGroupTitleTile> createState() => _TabGroupTitleTileState();
}

class _TabGroupTitleTileState extends ConsumerState<TabGroupTitleTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(FluentIcons.text_case_title_24_regular),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: const Text('TabGroup Title'),
      ),
      subtitle: TextFormField(
        decoration: InputDecoration(border: OutlineInputBorder()),

        initialValue: widget.tabGroup?.title,
        autovalidateMode: AutovalidateMode.always,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a TabGroup title';
          }

          return null;
        },
        onChanged: (value) {
          ref
              .read(
                editTabGroupFormProvider(
                  sessionId: widget.sessionId,
                  tabGroup: widget.tabGroup,
                ).notifier,
              )
              .setTitle(value);
        },
      ),
    );
  }
}
