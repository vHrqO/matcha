import 'package:flutter/material.dart';

import 'package:matcha/ui/widgets/shared/appbar/clip_board_button.dart';
import 'package:matcha/ui/widgets/shared/appbar/opened_tabs_button.dart';
import 'package:matcha/ui/widgets/shared/appbar/settings_button.dart';
import 'package:matcha/ui/widgets/shared/appbar/sync_button.dart';

class TrailingSection extends StatelessWidget {
  const TrailingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          // Tooltip(message: 'Clip Board', child: ClipBoardPopupButton()),

          Tooltip(message: 'Opened Tabs', child: OpenedTabsButton()),

          Tooltip(message: 'Sync !', child: SyncButton()),

          Tooltip(message: 'Settings', child: SettingsButton()),
        ],
      ),
    );
  }
}
