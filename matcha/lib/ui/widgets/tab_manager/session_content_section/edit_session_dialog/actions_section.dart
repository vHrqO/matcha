import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:matcha/model/session/session.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/edit_session_dialog_viewmodel.dart';
import 'package:matcha/view_model/tab_manager/session_list_viewmodel.dart';

class ActionsSection extends ConsumerWidget {
  const ActionsSection(this.session, {super.key});

  final Session session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editSessionFormValid = ref.watch(editSessionFormProvider(session));

    return Row(
      spacing: 8.0,
      children: [
        DeleteButton(session.id),

        Spacer(),

        OutlinedButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FilledButton(
          child: const Text("Save"),
          onPressed: editSessionFormValid
              ? () {
                  ref.read(editSessionFormProvider(session).notifier).save();
                  Navigator.of(context).pop();
                }
              : null,
        ),
      ],
    );
  }
}

class DeleteButton extends ConsumerWidget {
  const DeleteButton(this.sessionId, {super.key});

  final int sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButton.tonal(
      child: const Text("Delete"),
      onPressed: () async {
        final bool? result = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Delete Session"),
              content: const Text("Are you sure you want to delete this session?"),
              actions: [
                OutlinedButton(
                  child: const Text("Delete"),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                FilledButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );

        //
        if (result == true) {
          ref.read(sessionListProvider.notifier).delete(sessionId);
          Navigator.of(context).pop();
        }
      },
    );
  }
}
