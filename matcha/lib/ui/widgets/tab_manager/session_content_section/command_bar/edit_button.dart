import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:matcha/model/tabs_item/tabs_item.dart';
import 'package:matcha/view_model/shared/selected_viewmodel.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/command_bar/edit_button_viewmodel.dart';

class EditButtonRx extends ConsumerWidget {
  const EditButtonRx({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSessionIdAsync = ref.watch(selectedSessionIdProvider);
    final editButton = ref.watch(editButtonProvider);

    return IconButton(
      icon: const Icon(FluentIcons.edit_24_regular),

      onPressed: switch (selectedSessionIdAsync) {
        AsyncData(value: final int id) when editButton => () {
          ref.read(editButtonProvider.notifier).showEditDialog(context, id);
        },
        _ => null,
      },
    );
  }
}

class EditButtonTapRx extends ConsumerWidget {
  const EditButtonTapRx({super.key, required this.tabsItem});

  final TabsItem tabsItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSessionIdAsync = ref.watch(selectedSessionIdProvider);

    return IconButton(
      icon: const Icon(FluentIcons.edit_24_regular),

      onPressed: switch (selectedSessionIdAsync) {
        AsyncData(value: final int id) => () {
          editButtonTap(context, tabsItem, id);
        },
        _ => null,
      },
    );
  }
}
