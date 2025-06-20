import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:matcha/ui/views/tab_manager/edit_session_dialog.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/session_content_viewmodel.dart';
import 'package:matcha/model/session/session.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const TitleRx(),

            const Spacer(),

            IconButton(
              icon: const Icon(FluentIcons.edit_settings_20_regular),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const EditSessionDialogRx();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TitleRx extends ConsumerWidget {
  const TitleRx({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSessionAsync = ref.watch(selectedSessionProvider);

    switch (selectedSessionAsync) {
      case AsyncData(value: final Session session):
        return Text(session.name, style: Theme.of(context).textTheme.titleLarge);

      case AsyncError(error: final error, stackTrace: final stackTrace):
        // to_do: use notification
        return Text('Oops, something unexpected happened: $error');

      default:
        return const Skeletonizer(child: Text('sessionName'));
    }
  }
}
