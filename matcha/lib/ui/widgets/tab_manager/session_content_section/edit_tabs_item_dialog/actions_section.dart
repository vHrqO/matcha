import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;
import 'package:matcha/model/tabs_item/tabs_item.dart';
import 'package:matcha/view_model/shared/selected_viewmodel.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/edit_tabs_item_dialog_viewmodel.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/session_content_viewmodel.dart';

class TabActionsSection extends ConsumerWidget {
  const TabActionsSection({super.key, required this.sessionId, this.tab});

  // null as add
  final int sessionId;
  final matcha_tab.Tab? tab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editTabFormValid = ref.watch(
      editTabFormProvider(sessionId: sessionId, tab: tab),
    );

    return Row(
      spacing: 8.0,
      children: [
        if (tab != null) DeleteButton(sessionId: sessionId, tabsItem: tab!),

        Spacer(),

        OutlinedButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FilledButton(
          child: (tab != null) ? const Text("Save") : const Text("Add"),
          onPressed: editTabFormValid
              ? () {
                  ref
                      .read(
                        editTabFormProvider(sessionId: sessionId, tab: tab).notifier,
                      )
                      .save();
                  Navigator.of(context).pop();
                }
              : null,
        ),
      ],
    );
  }
}

class TabGroupActionsSection extends ConsumerWidget {
  const TabGroupActionsSection({super.key, required this.sessionId, this.tabGroup});

  // null as add
  final int sessionId;
  final matcha_tab_group.TabGroup? tabGroup;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editTabGroupFormValid = ref.watch(
      editTabGroupFormProvider(sessionId: sessionId, tabGroup: tabGroup),
    );

    return Row(
      spacing: 8.0,
      children: [
        if (tabGroup != null) DeleteButton(sessionId: sessionId, tabsItem: tabGroup!),

        Spacer(),

        OutlinedButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FilledButton(
          child: (tabGroup != null) ? const Text("Save") : const Text("Add"),
          onPressed: editTabGroupFormValid
              ? () {
                  ref
                      .read(
                        editTabGroupFormProvider(
                          sessionId: sessionId,
                          tabGroup: tabGroup,
                        ).notifier,
                      )
                      .save();
                  Navigator.of(context).pop();
                }
              : null,
        ),
      ],
    );
  }
}

//
class DeleteButton extends ConsumerWidget {
  const DeleteButton({super.key, required this.sessionId, required this.tabsItem});

  final int sessionId;
  final TabsItem tabsItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButton.tonal(
      child: const Text("Delete"),
      onPressed: () async {
        ref.read(selectedTabsItemProvider.notifier).clearSelected();
        await ref
            .read(sessionContentProvider(sessionId).notifier)
            .removeTabsItem(tabsItem.id);

        Navigator.of(context).pop();
      },
    );
  }
}
