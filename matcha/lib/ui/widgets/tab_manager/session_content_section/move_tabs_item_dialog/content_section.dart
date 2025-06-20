import 'package:flutter/material.dart';

import 'package:matcha/model/session/session_meta.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/move_tabs_item_dialog/sessions_dropdown_menu_tile.dart';

class ContentSection extends StatelessWidget {
  const ContentSection({
    super.key,
    required this.sessionId,
    required this.sessionMetaList,
  });

  final int sessionId;
  final List<SessionMeta> sessionMetaList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SessionDropdownMenuTile(sessionId: sessionId, sessionMetaList: sessionMetaList),
      ],
    );
  }
}
