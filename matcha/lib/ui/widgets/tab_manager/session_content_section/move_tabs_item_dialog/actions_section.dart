import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:matcha/view_model/tab_manager/session_content_section/move_tabs_item_dialog_viewmodel.dart';

class ActionsSection extends ConsumerWidget {
  const ActionsSection({super.key, required this.sessionId});

  final int sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moveTabsItemFormValid = ref.watch(moveTabsItemFormProvider(sessionId));

    return Row(
      spacing: 8.0,
      children: [
        Spacer(),

        OutlinedButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FilledButton(
          child: const Text("Move"),
          onPressed: moveTabsItemFormValid
              ? () async {
                  await ref.read(moveTabsItemFormProvider(sessionId).notifier).save();
                  Navigator.of(context).pop();
                }
              : null,
        ),
      ],
    );
  }
}
