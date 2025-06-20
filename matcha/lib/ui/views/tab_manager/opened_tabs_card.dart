import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:matcha/app/constants.dart';
import 'package:matcha/model/browser_window.dart';
import 'package:matcha/ui/widgets/opened_tabs_card/opened_tabs_list.dart';
import 'package:matcha/ui/views/tab_manager/tabs_item_list_section.dart';
import 'package:matcha/ui/widgets/opened_tabs_card/tab_view_section.dart';
import 'package:matcha/ui/widgets/opened_tabs_card/title_section.dart';

import 'package:matcha/ui/widgets/shared/sort_dropdown_button.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/edit_tabs_item_dialog/content_section.dart';
import 'package:matcha/view_model/tab_manager/opened_tabs_card/opened_tabs_card_viewmodel.dart';

// opened_tabs_card_viewmodel

class OpenedTabsCard extends ConsumerStatefulWidget {
  const OpenedTabsCard({super.key});

  @override
  ConsumerState<OpenedTabsCard> createState() => _OpenedTabsCardState();
}

class _OpenedTabsCardState extends ConsumerState<OpenedTabsCard> {
  @override
  Widget build(BuildContext context) {
    final windowListAsync = ref.watch(windowListProvider);

    return Card(
      child: Column(
        children: [
          TitleSection(),

          SizedBox(height: 12.0),

          // TabViewSection
          Expanded(
            child: switch (windowListAsync) {
              AsyncData(value: final List<BrowserWindow> windowList) => TabViewSection(
                tabLength: windowList.length,
              ),
              _ => Center(child: CircularProgressIndicator()),
            },
          ),

          //
        ],
      ),
    );
  }
}
