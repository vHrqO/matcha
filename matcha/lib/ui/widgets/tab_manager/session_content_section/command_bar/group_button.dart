import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:matcha/view_model/shared/selected_viewmodel.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/command_bar/group_button_viewmodel.dart';

class GroupButtonRx extends ConsumerWidget {
  const GroupButtonRx({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSessionIdAsync = ref.watch(selectedSessionIdProvider);
    final groupButton = ref.watch(groupButtonProvider);

    return IconButton(
      icon: const Icon(FluentIcons.cube_sync_24_regular),

      onPressed: switch (selectedSessionIdAsync) {
        AsyncData(value: final int id) when groupButton => () {
          ref.read(groupButtonProvider.notifier).toggle(id);
        },
        _ => null,
      },
    );
  }
}
