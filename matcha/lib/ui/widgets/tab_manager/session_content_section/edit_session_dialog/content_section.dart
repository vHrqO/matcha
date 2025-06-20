import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:matcha/model/session/session.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/edit_session_dialog_viewmodel.dart';

class ContentSection extends StatelessWidget {
  const ContentSection(this.session, {super.key});

  final Session session;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        SessionNameTile(session),
      ],
    );
  }
}

//
class SessionNameTile extends ConsumerStatefulWidget {
  const SessionNameTile(this.session, {super.key});

  final Session session;

  @override
  ConsumerState<SessionNameTile> createState() => _SessionNameTileState();
}

class _SessionNameTileState extends ConsumerState<SessionNameTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(FluentIcons.edit_20_regular),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: const Text("Session Name"),
      ),
      subtitle: TextFormField(
        decoration: InputDecoration(border: OutlineInputBorder()),
        initialValue: widget.session.name,

        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a session name';
          }

          return null;
        },
        onChanged: (value) {
          ref
              .read(editSessionFormProvider(widget.session).notifier)
              .setSessionName(value);
        },
      ),
    );
  }
}
