import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/view_model/tab_manager/session_content_section/edit_tabs_item_dialog_viewmodel.dart';

class TabUrlTile extends ConsumerStatefulWidget {
  const TabUrlTile({super.key, required this.sessionId, this.tab});

  final int sessionId;
  final matcha_tab.Tab? tab;

  @override
  ConsumerState<TabUrlTile> createState() => _TabUrlTileState();
}

class _TabUrlTileState extends ConsumerState<TabUrlTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(FluentIcons.link_24_regular),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: const Text('Tab URL'),
      ),
      subtitle: TextFormField(
        decoration: InputDecoration(border: OutlineInputBorder()),

        initialValue: widget.tab?.url,
        autovalidateMode: AutovalidateMode.always,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a tab URL';
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
              .setUrl(value);
        },
      ),
    );
  }
}
