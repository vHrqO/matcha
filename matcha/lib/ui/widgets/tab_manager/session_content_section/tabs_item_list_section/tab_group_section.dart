import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;
import 'package:matcha/model/tabs_item/tabs_item.dart';
import 'package:matcha/view_model/shared/selected_viewmodel.dart';
import 'package:matcha/mock_data/tab_group.dart';
import 'package:matcha/ui/widgets/shared/tabs_item/tab_group_card.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/tabs_item_list_section/session_hovermenu.dart'
    as session_hovermenu;
import 'package:matcha/ui/widgets/opened_tabs_card/opened_tabs_hovermenu.dart'
    as opened_tabs_hovermenu;

class TabGroupSectionRx extends ConsumerWidget {
  const TabGroupSectionRx({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTabGroupAsync = ref.watch(selectedTabGroupProvider);

    switch (selectedTabGroupAsync) {
      case AsyncData(value: final matcha_tab_group.TabGroup selectedTabGroup):
      case AsyncLoading(value: final matcha_tab_group.TabGroup selectedTabGroup):
        // change hoverMenu builder based on type
        if (selectedTabGroup.type == TabsItemType.app) {
          return TabGroupCard(
            tabGroup: selectedTabGroup,
            hoverMenuBuilder: (tab) {
              return session_hovermenu.SectionTabHoverMenu(tab: tab);
            },
          );
        } else {
          return TabGroupCard(
            tabGroup: selectedTabGroup,
            hoverMenuBuilder: (tab) {
              return opened_tabs_hovermenu.SectionTabHoverMenu(tab: tab);
            },
          );
        }

      default:
        return Skeletonizer(
          ignorePointers: false,

          child: TabGroupCard(
            tabGroup: mockTabGroup,
            hoverMenuBuilder: (tab) {
              return const Placeholder();
            },
          ),
        );
    }
  }
}
