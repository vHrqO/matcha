import 'package:flutter/material.dart';

import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;
import 'package:matcha/ui/widgets/shared/edit_dialog.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/edit_tabs_item_dialog/actions_section.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/edit_tabs_item_dialog/content_section.dart';

class AddTabGroupDialog extends StatelessWidget {
  const AddTabGroupDialog({super.key, required this.sessionId});

  final int sessionId;

  @override
  Widget build(BuildContext context) {
    return EditDialog(
      title: "Add TabGroup",
      content: TabGroupContentSection(sessionId: sessionId, tabGroup: null),
      actions: TabGroupActionsSection(sessionId: sessionId, tabGroup: null),
    );
  }
}

class EditTabGroupDialog extends StatelessWidget {
  const EditTabGroupDialog({
    super.key,
    required this.sessionId,
    required this.tabGroup,
  });

  final int sessionId;
  final matcha_tab_group.TabGroup tabGroup;

  @override
  Widget build(BuildContext context) {
    return EditDialog(
      title: "Edit TabGroup",
      content: TabGroupContentSection(sessionId: sessionId, tabGroup: tabGroup),
      actions: TabGroupActionsSection(sessionId: sessionId, tabGroup: tabGroup),
    );
  }
}
