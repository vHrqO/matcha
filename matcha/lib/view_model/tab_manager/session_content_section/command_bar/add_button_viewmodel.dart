import 'package:flutter/material.dart';

import 'package:matcha/ui/widgets/tab_manager/session_content_section/edit_tabs_item_dialog/edit_tab_dialog.dart';

void addButtonTap(BuildContext context, int sessionId) {
  showDialog(
    context: context,
    builder: (context) {
      return AddTabDialog(sessionId: sessionId);
    },
  );
}
