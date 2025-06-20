import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:matcha/model/tabs_item/tabs_item.dart';
import 'package:matcha/view_model/shared/selected_viewmodel.dart';
import 'package:matcha/view_model/tab_manager/opened_tabs_card/save_button_viewmodel.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/command_bar/edit_button_viewmodel.dart';

class SaveButtonTapRx extends ConsumerWidget {
  const SaveButtonTapRx({super.key, required this.tabsItem});

  final TabsItem tabsItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saveButtonAsync = ref.watch(saveButtonProvider);

    return IconButton(
      icon: const Icon(FluentIcons.tray_item_add_24_regular),

      onPressed: switch (saveButtonAsync) {
        AsyncData(value: final bool enabled) when enabled => () {
          ref.read(saveButtonProvider.notifier).save(tabsItem);
        },
        _ => null,
      },
    );
  }
}
