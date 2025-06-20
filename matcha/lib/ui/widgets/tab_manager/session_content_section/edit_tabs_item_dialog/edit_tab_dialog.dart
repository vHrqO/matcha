import 'package:flutter/material.dart';

import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/ui/widgets/shared/edit_dialog.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/edit_tabs_item_dialog/actions_section.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/edit_tabs_item_dialog/content_section.dart';

class AddTabDialog extends StatelessWidget {
  const AddTabDialog({super.key, required this.sessionId});

  final int sessionId;

  @override
  Widget build(BuildContext context) {
    return EditDialog(
      title: "Add Tab",
      content: TabContentSection(sessionId: sessionId, tab: null),
      actions: TabActionsSection(sessionId: sessionId, tab: null),
    );
  }
}

class EditTabDialog extends StatelessWidget {
  const EditTabDialog({super.key, required this.sessionId, required this.tab});

  final int sessionId;
  final matcha_tab.Tab tab;

  @override
  Widget build(BuildContext context) {
    return EditDialog(
      title: "Edit Tab",
      content: TabContentSection(sessionId: sessionId, tab: tab),
      actions: TabActionsSection(sessionId: sessionId, tab: tab),
    );
  }
}
