import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:matcha/app/constants.dart';
import 'package:matcha/view_model/tab_manager/session_list_viewmodel.dart';
import 'package:matcha/ui/widgets/shared/single_textbox_dialog.dart';
import 'package:matcha/ui/widgets/shared/sort_dropdown_button.dart';

class TitleBar extends ConsumerWidget {
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Text('Sessions', style: Theme.of(context).textTheme.titleMedium),

        Spacer(),

        Tooltip(
          message: 'Sort',
          child: SortDropdownButton(
            initialSelection: SortOrder.custom,
            onSelected: (sortOrder) {
              ref.read(sessionListSortOrderProvider.notifier).setOrder(sortOrder);
            },
          ),
        ),

        Tooltip(
          message: "Add",
          child: IconButton(
            padding: const EdgeInsets.all(0.0),
            iconSize: 20,
            icon: const Icon(Icons.add),

            onPressed: () async {
              final String? sessionName = await showDialog(
                context: context,
                builder: (context) {
                  return SingleTextBoxDialog(
                    title: 'Add Session',
                    labelText: 'Session Name',
                    submitButtonText: 'Add',
                  );
                },
              );

              if (sessionName != null && sessionName.isNotEmpty) {
                ref.read(sessionListProvider.notifier).addSession(sessionName);
              }
            },
          ),
        ),
      ],
    );
  }
}
