import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:matcha/model/session/session.dart';
import 'package:matcha/ui/widgets/shared/edit_dialog.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/edit_session_dialog/actions_section.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/edit_session_dialog/content_section.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/session_content_viewmodel.dart';

class EditSessionDialogRx extends ConsumerWidget {
  const EditSessionDialogRx({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSessionAsync = ref.watch(selectedSessionProvider);

    switch (selectedSessionAsync) {
      case AsyncData(value: final Session session):
        return EditDialog(
          title: "Edit Session",
          content: ContentSection(session),
          actions: ActionsSection(session),
        );

      case AsyncError(error: final error, stackTrace: final stackTrace):
        // to_do: use notification
        return Text('Oops, something unexpected happened: $error');

      default:
        return const EditDialog(
          title: "Edit Session",
          content: Skeletonizer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(title: Text("Tile Name")),
                ListTile(title: Text("Tile Name")),
              ],
            ),
          ),
        );
    }
  }
}
