import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/view_model/shared/selected_viewmodel.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/command_bar/move_group_button_viewmodel.dart';

/// MoveToGroup
///
class MoveToGroupButtonRx extends ConsumerWidget {
  const MoveToGroupButtonRx({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSessionIdAsync = ref.watch(selectedSessionIdProvider);
    final moveToGroupButton = ref.watch(moveToGroupButtonProvider);

    return IconButton(
      icon: const Icon(FluentIcons.arrow_step_in_right_24_regular),

      onPressed: switch (selectedSessionIdAsync) {
        AsyncData(value: final int id) when moveToGroupButton => () {
          ref.read(moveToGroupButtonProvider.notifier).move(id);
        },
        _ => null,
      },
    );
  }
}

class MoveToGroupButtonTapRx extends ConsumerWidget {
  const MoveToGroupButtonTapRx(this.tab, {super.key});

  final matcha_tab.Tab tab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSessionIdAsync = ref.watch(selectedSessionIdProvider);
    final moveToGroupButtonTap = ref.watch(moveToGroupButtonTapProvider);

    return IconButton(
      icon: const Icon(FluentIcons.arrow_step_in_right_24_regular),

      onPressed: switch (selectedSessionIdAsync) {
        AsyncData(value: final int id) when moveToGroupButtonTap => () {
          ref.read(moveToGroupButtonTapProvider.notifier).move(id, tab);
        },
        _ => null,
      },
    );
  }
}

/// MoveOutGroup
///
class MoveOutGroupButtonRx extends ConsumerWidget {
  const MoveOutGroupButtonRx({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSessionIdAsync = ref.watch(selectedSessionIdProvider);
    final moveOutGroupButton = ref.watch(moveOutGroupButtonProvider);

    return IconButton(
      icon: const Icon(FluentIcons.arrow_step_in_left_24_regular),

      onPressed: switch (selectedSessionIdAsync) {
        AsyncData(value: final int id) when moveOutGroupButton => () {
          ref.read(moveOutGroupButtonProvider.notifier).move(id);
        },
        _ => null,
      },
    );
  }
}

class MoveOutGroupButtonTapRx extends ConsumerWidget {
  const MoveOutGroupButtonTapRx(this.tab, {super.key});

  final matcha_tab.Tab tab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSessionIdAsync = ref.watch(selectedSessionIdProvider);
    final moveOutGroupButtonTap = ref.watch(moveOutGroupButtonTapProvider);

    return IconButton(
      icon: const Icon(FluentIcons.arrow_step_in_left_24_regular),

      onPressed: switch (selectedSessionIdAsync) {
        AsyncData(value: final int id) when moveOutGroupButtonTap => () {
          ref.read(moveOutGroupButtonTapProvider.notifier).move(id, tab);
        },
        _ => null,
      },
    );
  }
}
