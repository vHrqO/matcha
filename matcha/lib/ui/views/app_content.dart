import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:matcha/app/constants.dart' as constants;
import 'package:matcha/ui/views/tab_manager/session_list_card.dart';
import 'package:matcha/ui/views/tab_manager/session_content_section.dart';
import 'package:matcha/ui/views/bookmarks_manager/left_side.dart';
import 'package:matcha/ui/views/bookmarks_manager/bookmarks.dart';
import 'package:matcha/ui/views/tab_manager/opened_tabs_card.dart';
import 'package:matcha/view_model/shared/app_viewmodel.dart';

class AppContent extends ConsumerStatefulWidget {
  const AppContent({super.key, required this.tabController});

  final TabController tabController;

  @override
  ConsumerState<AppContent> createState() => _AppContentState();
}

class _AppContentState extends ConsumerState<AppContent> {
  bool _rightSideSize = true;
  bool _rightSideVisible = true;
  bool _rightSideOpacity = true;

  @override
  Widget build(BuildContext context) {
    final rightSideOpened = ref.watch(rightSideOpenedProvider);

    // show rightSide
    if (rightSideOpened && !_rightSideVisible) {
      _rightSideSize = true;

      Future.delayed(constants.AnimationSettings.duration, () {
        setState(() {
          _rightSideVisible = true;
          _rightSideOpacity = true;
        });
      });
    }

    // hide rightSide
    if (!rightSideOpened && _rightSideVisible) {
      _rightSideOpacity = false;

      Future.delayed(constants.AnimationSettings.duration, () {
        setState(() {
          _rightSideVisible = false;
          _rightSideSize = false;
        });
      });
    }

    //
    return Expanded(
      child: Row(
        children: [
          // tabs , tabs group > session >  workspaces

          // leftside
          AnimatedContainer(
            duration: constants.AnimationSettings.duration,
            curve: constants.AnimationSettings.curve,

            width: MediaQuery.of(context).size.width * 0.15,
            padding: const EdgeInsets.all(8.0),

            child: TabBarView(
              controller: widget.tabController,
              children: const [
                // tab_manager
                SessionListCard(),

                // bookmarks_manager
                LeftSideCard(),
              ],
            ),
          ),

          // center
          AnimatedContainer(
            duration: constants.AnimationSettings.duration,
            curve: constants.AnimationSettings.curve,

            width: _rightSideSize
                ? MediaQuery.of(context).size.width * 0.65
                : MediaQuery.of(context).size.width * 0.85,
            padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),

            child: TabBarView(
              controller: widget.tabController,
              children: const [
                // tab_manager
                SessionContentSection(),

                // bookmarks_manager
                BookmarksCard(),
              ],
            ),
          ),

          // rightside
          AnimatedContainer(
            duration: constants.AnimationSettings.duration,
            curve: constants.AnimationSettings.curve,

            width: _rightSideSize ? MediaQuery.of(context).size.width * 0.2 : 0,
            padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),

            child: AnimatedOpacity(
              duration: constants.AnimationSettings.duration,
              curve: constants.AnimationSettings.curve,
              opacity: _rightSideOpacity ? 1.0 : 0,

              child: _rightSideVisible ? const OpenedTabsCard() : null,
            ),
          ),

          //
        ],
      ),
    );
  }
}


//

