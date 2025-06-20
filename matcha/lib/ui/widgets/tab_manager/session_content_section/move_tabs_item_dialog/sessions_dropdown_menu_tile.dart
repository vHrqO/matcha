import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:matcha/model/session/session_meta.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/move_tabs_item_dialog_viewmodel.dart';

class SessionDropdownMenuTile extends ConsumerStatefulWidget {
  const SessionDropdownMenuTile({
    super.key,
    required this.sessionId,
    required this.sessionMetaList,
  });

  final int sessionId;
  final List<SessionMeta> sessionMetaList;

  @override
  ConsumerState<SessionDropdownMenuTile> createState() =>
      _SessionDropdownMenuTileState();
}

class _SessionDropdownMenuTileState extends ConsumerState<SessionDropdownMenuTile> {
  final TextEditingController textController = TextEditingController();

  int? _moveToSessionId;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(FluentIcons.library_24_regular),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: const Text('Session'),
      ),
      subtitle: LayoutBuilder(
        builder: (context, constraints) {
          return DropdownMenu<int>(
            width: constraints.maxWidth,
            requestFocusOnTap: true,
            controller: textController,
            label: const Text('Select a Session'),

            dropdownMenuEntries: getSessionEntries(widget.sessionMetaList),
            initialSelection: widget.sessionId,

            onSelected: (int? sessionId) {
              setState(() {
                _moveToSessionId = sessionId;
              });

              ref
                  .read(moveTabsItemFormProvider(widget.sessionId).notifier)
                  .setMoveToSessionId(_moveToSessionId);
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
