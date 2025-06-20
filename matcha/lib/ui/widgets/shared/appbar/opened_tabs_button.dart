import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:matcha/view_model/shared/app_viewmodel.dart';

class OpenedTabsButton extends ConsumerWidget {
  const OpenedTabsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rightSideOpened = ref.watch(rightSideOpenedProvider);

    return IconButton.filled(
      icon: const Icon(FluentIcons.tab_desktop_multiple_24_regular),
      isSelected: rightSideOpened,
      onPressed: () {
        ref.read(rightSideOpenedProvider.notifier).toggle(!rightSideOpened);
      },
    );
  }
}
