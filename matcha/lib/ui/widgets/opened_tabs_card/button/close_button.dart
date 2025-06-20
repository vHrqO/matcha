import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:matcha/model/tabs_item/tabs_item.dart';
import 'package:matcha/view_model/shared/selected_viewmodel.dart';
import 'package:matcha/view_model/tab_manager/opened_tabs_card/close_button_viewmodel.dart';

class CloseButtonTapRx extends ConsumerWidget {
  const CloseButtonTapRx({super.key, required this.tabsItem});

  final TabsItem tabsItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final closeButtonAsync = ref.watch(closeButtonProvider);

    return IconButton(
      icon: const Icon(Icons.close_outlined),

      onPressed: switch (closeButtonAsync) {
        AsyncData(value: final bool enabled) when enabled  => () {
          ref.read(closeButtonProvider.notifier).close(tabsItem);
        },
        _ => null,
      },
    );
  }
}
