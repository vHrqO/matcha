import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:matcha/model/tabs_item/tabs_item.dart';
import 'package:matcha/view_model/shared/selected_viewmodel.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/command_bar/open_button_viewmodel.dart';

class OpenButtonRx extends ConsumerWidget {
  const OpenButtonRx({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSessionIdAsync = ref.watch(selectedSessionIdProvider);
    final openButton = ref.watch(openButtonProvider);

    return IconButton(
      icon: const Icon(FluentIcons.open_20_regular),

      onPressed: switch (selectedSessionIdAsync) {
        AsyncData(value: final int id) when openButton => () {
          ref.read(openButtonProvider.notifier).open();
        },
        _ => null,
      },
    );
  }
}

class OpenButton extends ConsumerWidget {
  const OpenButton({super.key, required this.tabsItem});

  final TabsItem tabsItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(FluentIcons.open_20_regular),
      onPressed: () {
        openButtonTap(tabsItem);
      },
    );
  }
}
