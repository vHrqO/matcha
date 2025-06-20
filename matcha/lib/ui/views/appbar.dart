import 'package:flutter/material.dart';

import 'package:matcha/ui/widgets/shared/appbar/leading_section.dart';
import 'package:matcha/ui/widgets/shared/appbar/search_bar_section.dart';
import 'package:matcha/ui/widgets/shared/appbar/trailing_section.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LeadingSection(tabController: tabController),

          const SearchBarSection(),

          const TrailingSection(),
        ],
      ),
    );
  }
}
