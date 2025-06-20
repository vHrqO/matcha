import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:matcha/view_model/shared/selected_viewmodel.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/command_bar/move_button_viewmodel.dart';

class MoveButtonRx extends ConsumerWidget {
  const MoveButtonRx({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSessionIdAsync = ref.watch(selectedSessionIdProvider);
    final moveButton = ref.watch(moveButtonProvider);

    return IconButton(
      icon: const Icon(FluentIcons.folder_arrow_right_24_regular),

      onPressed: switch (selectedSessionIdAsync) {
        AsyncData(value: final int id) when moveButton => () {
          ref.read(moveButtonProvider.notifier).showMoveTabsItemDialog(context, id);
        },
        _ => null,
      },
    );
  }
}
