import 'package:flutter/material.dart';

import 'package:matcha/ui/widgets/tab_manager/session_list_card/session_list.dart';
import 'package:matcha/ui/widgets/tab_manager/session_list_card/title_bar.dart';

class SessionListCard extends StatelessWidget {
  const SessionListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(padding: const EdgeInsets.all(12.0), child: TitleBar()),

          Expanded(child: SessionListRx()),
        ],
      ),
    );
  }
}
