import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:matcha/model/browser_window.dart';
import 'package:matcha/ui/views/tab_manager/opened_tabs_card.dart';
import 'package:matcha/ui/widgets/opened_tabs_card/opened_tabs_list.dart';
import 'package:matcha/ui/widgets/opened_tabs_card/tab_view_section.dart';
import 'package:matcha/view_model/shared/selected_viewmodel.dart';
import 'package:matcha/view_model/tab_manager/opened_tabs_card/opened_tabs_card_viewmodel.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TabViewSection extends ConsumerStatefulWidget {
  const TabViewSection({super.key, required this.tabLength});

  final int tabLength;

  @override
  ConsumerState<TabViewSection> createState() => _TabViewSectionState();
}

class _TabViewSectionState extends ConsumerState<TabViewSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabLength, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        ref
            .read(selectedWindowIdProvider.notifier)
            .updateSelected(_tabController.index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //
        TabBarRx(_tabController),
        TabBarViewRx(_tabController),
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class TabBarRx extends ConsumerWidget {
  const TabBarRx(this.tabController, {super.key});

  final TabController tabController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final windowListAsync = ref.watch(windowListProvider);

    switch (windowListAsync) {
      case AsyncData(value: final List<BrowserWindow> windowList):
        return TabBar(
          controller: tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,

          tabs: List.generate(windowList.length, (index) {
            return Tab(
              child: Tooltip(
                message: "Window ${index + 1}",
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: [
                    const Icon(FluentIcons.window_24_regular),
                    Text((index + 1).toString()),
                  ],
                ),
              ),
            );
          }),
        );

      default:
        return const Skeletonizer(
          child: Row(
            children: [
              Tab(text: "Tab 1"),
              Tab(text: "Tab 2"),
            ],
          ),
        );
    }
  }
}

class TabBarViewRx extends ConsumerWidget {
  const TabBarViewRx(this.tabController, {super.key});

  final TabController tabController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final windowListAsync = ref.watch(windowListProvider);

    switch (windowListAsync) {
      case AsyncData(value: final List<BrowserWindow> windowList):
        return Expanded(
          child: TabBarView(
            controller: tabController,
            children: List.generate(windowList.length, (index) {
              return TabsItemListRx(windowId: windowList[index].id);
            }),
          ),
        );

      default:
        return Center(child: CircularProgressIndicator());
    }
  }
}
