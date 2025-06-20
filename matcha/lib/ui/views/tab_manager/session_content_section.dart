import 'package:flutter/material.dart';

import 'package:matcha/ui/widgets/tab_manager/session_content_section/command_bar/command_bar.dart';
import 'package:matcha/ui/views/tab_manager/tabs_item_list_section.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/status_bar.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/title_bar.dart';

class SessionContentSection extends StatelessWidget {
  const SessionContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleBar(),

        CommandBar(),

        Expanded(child: TabsItemListSection()),

        StatusBar(),
      ],
    );
  }
}
