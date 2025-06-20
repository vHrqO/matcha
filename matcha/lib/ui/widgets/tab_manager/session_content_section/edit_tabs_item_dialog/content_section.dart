import 'package:flutter/material.dart';

import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;
import 'package:matcha/ui/widgets/tab_manager/session_content_section/edit_tabs_item_dialog/tag_tile.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/edit_tabs_item_dialog/title_tile.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/edit_tabs_item_dialog/url_tile.dart';

class TabContentSection extends StatelessWidget {
  const TabContentSection({super.key, required this.sessionId, this.tab});

  final int sessionId;
  final matcha_tab.Tab? tab;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TabTitleTile(sessionId: sessionId, tab: tab),
        TabUrlTile(sessionId: sessionId, tab: tab),
        TabTagTileRx(sessionId: sessionId, tab: tab),
      ],
    );
  }
}

class TabGroupContentSection extends StatelessWidget {
  const TabGroupContentSection({super.key, required this.sessionId, this.tabGroup});

  final int sessionId;
  final matcha_tab_group.TabGroup? tabGroup;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TabGroupTitleTile(sessionId: sessionId, tabGroup: tabGroup),
        TabGroupTagTileRx(sessionId: sessionId, tabGroup: tabGroup),
      ],
    );
  }
}
