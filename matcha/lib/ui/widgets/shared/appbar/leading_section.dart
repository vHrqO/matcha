import 'package:flutter/material.dart';

class LeadingSection extends StatelessWidget {
  const LeadingSection({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        tabs: const [
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [Icon(Icons.tab_outlined, size: 16), Text("Tab")],
            ),
          ),

          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [Icon(Icons.bookmarks_outlined, size: 16), Text("Bookmark")],
            ),
          ),
        ],
      ),
    );
  }
}
