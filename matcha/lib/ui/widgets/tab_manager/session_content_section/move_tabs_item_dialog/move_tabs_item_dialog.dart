import 'package:flutter/material.dart';

import 'package:matcha/model/session/session_meta.dart';
import 'package:matcha/ui/widgets/shared/edit_dialog.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/move_tabs_item_dialog/actions_section.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/move_tabs_item_dialog/content_section.dart';

class MoveTabsItemDialog extends StatelessWidget {
  const MoveTabsItemDialog({
    super.key,
    required this.sessionId,
    required this.sessionMetaList,
  });

  final int sessionId;
  final List<SessionMeta> sessionMetaList;

  @override
  Widget build(BuildContext context) {
    return EditDialog(
      title: "Move to",
      content: ContentSection(sessionId: sessionId, sessionMetaList: sessionMetaList),
      actions: ActionsSection(sessionId: sessionId),
    );
  }
}
