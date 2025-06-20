import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:matcha/app/constants.dart';
import 'package:matcha/ui/widgets/shared/select_dropdown_button.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/command_bar/select_dropdown_viewmodel.dart';

class SelectDropdown extends ConsumerWidget {
  const SelectDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectDropdownAsync = ref.watch(selectDropdownProvider);

    switch (selectDropdownAsync) {
      case AsyncData(value: final enabled) when enabled:
        return SelectDropdownButton(
          onItemPressed: (selectMethod) {
            switch (selectMethod) {
              case SelectMethod.selectAll:
                ref.read(selectDropdownProvider.notifier).selectAll();

              case SelectMethod.invertSelection:
                ref.read(selectDropdownProvider.notifier).invertSelection();

              case SelectMethod.clearSelection:
                ref.read(selectDropdownProvider.notifier).clearSelection();
            }
          },
        );

      case AsyncError(error: final error, stackTrace: final stackTrace):
        // to_do: use notification
        return SelectDropdownButton(onItemPressed: null);

      default:
        return SelectDropdownButton(onItemPressed: null);
    }
  }
}
