import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:matcha/view_model/shared/selected_viewmodel.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/command_bar/add_button_viewmodel.dart';

class AddButtonRx extends ConsumerWidget {
  const AddButtonRx({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSessionIdAsync = ref.watch(selectedSessionIdProvider);

    return TextButton.icon(
      label: const Text('Add'),
      icon: const Icon(Icons.add),

      onPressed: switch (selectedSessionIdAsync) {
        AsyncData(value: final int id) => () {
          addButtonTap(context, id);
        },
        _ => null,
      },
    );
  }
}
