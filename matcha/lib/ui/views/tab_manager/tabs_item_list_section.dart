import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:matcha/app/constants.dart' as constants;
import 'package:matcha/ui/widgets/tab_manager/session_content_section/tabs_item_list_section/tab_group_section.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/tabs_item_list_section/tabs_item_listview.dart';
import 'package:matcha/view_model/shared/app_viewmodel.dart';

class TabsItemListSection extends ConsumerStatefulWidget {
  const TabsItemListSection({super.key});

  @override
  ConsumerState<TabsItemListSection> createState() => _TabsItemListSectionState();
}

class _TabsItemListSectionState extends ConsumerState<TabsItemListSection> {
  bool _tabGroupSize = false;
  bool _tabGroupVisible = false;
  bool _tabGroupOpacity = false;

  @override
  Widget build(BuildContext context) {
    final tabGroupOpened = ref.watch(tabGroupOpenedProvider);

    // show tab group
    if (tabGroupOpened && !_tabGroupVisible) {
      _tabGroupSize = true;

      Future.delayed(constants.AnimationSettings.duration, () {
        setState(() {
          _tabGroupVisible = true;
          _tabGroupOpacity = true;
        });
      });
    }

    // hide tab group
    if (!tabGroupOpened && _tabGroupVisible) {
      _tabGroupOpacity = false;

      Future.delayed(constants.AnimationSettings.duration, () {
        setState(() {
          _tabGroupVisible = false;
          _tabGroupSize = false;
        });
      });
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            // TabsItemList
            AnimatedContainer(
              duration: constants.AnimationSettings.duration,
              curve: constants.AnimationSettings.curve,
              width: _tabGroupSize ? constraints.maxWidth / 2 : constraints.maxWidth,
              child: TabsItemListRx(),
            ),

            // tab group
            AnimatedContainer(
              duration: constants.AnimationSettings.duration,
              curve: constants.AnimationSettings.curve,
              width: _tabGroupSize ? constraints.maxWidth / 2 : 0,

              child: AnimatedOpacity(
                duration: constants.AnimationSettings.duration,
                curve: constants.AnimationSettings.curve,
                opacity: _tabGroupOpacity ? 1.0 : 0,

                child: _tabGroupVisible ? TabGroupSectionRx() : null,
              ),
            ),
          ],
        );
      },
    );
  }
}
