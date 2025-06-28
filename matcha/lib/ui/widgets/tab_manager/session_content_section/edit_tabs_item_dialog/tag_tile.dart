import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;
import 'package:matcha/ui/widgets/shared/tag_select_tile.dart';
import 'package:matcha/view_model/shared/database_viewmodel.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/edit_tabs_item_dialog_viewmodel.dart';

class TabTagTileRx extends ConsumerWidget {
  const TabTagTileRx({super.key, required this.sessionId, this.tab});

  final int sessionId;

  // null as add
  final matcha_tab.Tab? tab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final existingTags = ref.watch(existingTagsProvider).value ?? [];

    return ListTile(
      leading: const Icon(FluentIcons.tag_24_regular),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: const Text('Tab Tags'),
      ),
      subtitle: TagSelectTile(
        currentTags: tab?.tagList ?? [],
        availableSuggestTags: existingTags,
        tagsHasChanged: (currentTags) {
          ref
              .read(editTabFormProvider(sessionId: sessionId, tab: tab).notifier)
              .setTagList(currentTags);
        },
      ),
    );
  }
}

class TabGroupTagTileRx extends ConsumerWidget {
  const TabGroupTagTileRx({super.key, required this.sessionId, this.tabGroup});

  final int sessionId;

  // null as add
  final matcha_tab_group.TabGroup? tabGroup;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final existingTags = ref.watch(existingTagsProvider).value ?? [];

    return ListTile(
      leading: const Icon(FluentIcons.tag_24_regular),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: const Text('TabGroup Tags'),
      ),
      subtitle: TagSelectTile(
        currentTags: tabGroup?.tagList ?? [],
        availableSuggestTags: existingTags,
        tagsHasChanged: (currentTags) {
          ref
              .read(
                editTabGroupFormProvider(
                  sessionId: sessionId,
                  tabGroup: tabGroup,
                ).notifier,
              )
              .setTagList(currentTags);
        },
      ),
    );
  }
}
