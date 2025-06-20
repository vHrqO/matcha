import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:matcha/model/tabs_item/tabs_item.dart';
import 'package:matcha/view_model/shared/selected_viewmodel.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/command_bar/delete_button_viewmodel.dart';

class DeleteButtonRx extends ConsumerWidget {
  const DeleteButtonRx({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSessionIdAsync = ref.watch(selectedSessionIdProvider);
    final deleteButton = ref.watch(deleteButtonProvider);

    return IconButton(
      icon: const Icon(FluentIcons.delete_24_regular),

      onPressed: switch (selectedSessionIdAsync) {
        AsyncData(value: final int id) when deleteButton => () {
          ref.read(deleteButtonProvider.notifier).delete(id);
        },
        _ => null,
      },
    );
  }
}

class DeleteButtonTapRx extends ConsumerWidget {
  const DeleteButtonTapRx({super.key, required this.tabsItem});

  final TabsItem tabsItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deleteButtonTapAsync = ref.watch(deleteButtonTapProvider);

    return IconButton(
      icon: const Icon(FluentIcons.delete_24_regular),

      onPressed: switch (deleteButtonTapAsync) {
        AsyncData(value: final bool enabled) when enabled => () {
          ref.read(deleteButtonTapProvider.notifier).delete(tabsItem);
        },
        _ => null,
      },
    );
  }
}
