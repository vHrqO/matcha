import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:matcha/app/constants.dart';
import 'package:matcha/ui/widgets/shared/sort_dropdown_button.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/session_content_viewmodel.dart';

class SortDropdown extends ConsumerWidget {
  const SortDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SortDropdownButton(
      initialSelection: SortOrder.custom,
      onSelected: (sortOrder) {
        ref.read(tabsItemListSortOrderProvider.notifier).setOrder(sortOrder);
      },
    );
  }
}
