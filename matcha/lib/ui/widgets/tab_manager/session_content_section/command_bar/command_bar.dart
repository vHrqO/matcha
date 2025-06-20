import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:matcha/ui/widgets/tab_manager/session_content_section/command_bar/add_button.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/command_bar/delete_button.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/command_bar/edit_button.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/command_bar/group_button.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/command_bar/move_button.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/command_bar/move_group_button.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/command_bar/open_button.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/command_bar/select_dropdown.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/command_bar/sort_dropdown.dart';

class CommandBar extends StatelessWidget {
  const CommandBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          spacing: 8,
          children: [
            // left side
            Tooltip(message: 'Add', child: AddButtonRx()),

            SizedBox(height: 30, child: const VerticalDivider()),

            // // to_do: use clipboard
            // Tooltip(
            //   message: 'Cut',
            //   child: IconButton(
            //     icon: const Icon(FluentIcons.cut_20_regular),
            //     onPressed: () {
            //       // Add your action here
            //     },
            //   ),
            // ),

            // // use clipboard
            // Tooltip(
            //   message: 'Copy',
            //   child: IconButton(
            //     icon: const Icon(FluentIcons.copy_20_regular),
            //     onPressed: () {
            //       // Add your action here
            //     },
            //   ),
            // ),

            // // use clipboard
            // // use focus
            // Tooltip(
            //   message: 'Paste',
            //   child: IconButton(
            //     icon: const Icon(FluentIcons.clipboard_paste_20_regular),
            //     onPressed: () {
            //       // Add your action here
            //     },
            //   ),
            // ),
            Tooltip(message: 'Delete', child: DeleteButtonRx()),

            Tooltip(message: 'Move', child: MoveButtonRx()),

            Tooltip(message: 'Group / Ungroup', child: GroupButtonRx()),

            // to_do:link button
            // FolderLinkRegular
            // dialog ,dropdown , breadcrumb (path)

            //
            Tooltip(message: 'Edit', child: EditButtonRx()),

            Tooltip(message: 'Open', child: OpenButtonRx()),

            Tooltip(message: 'Move to Group', child: MoveToGroupButtonRx()),
            Tooltip(message: 'Move out of Group', child: MoveOutGroupButtonRx()),

            // to_do: add more dropdown buttons for more actions
            const Spacer(),

            // test
            // TextButton(child: Text("test"), onPressed: () {}),

            // right side
            Tooltip(message: 'Select', child: SelectDropdown()),

            Tooltip(message: 'Sort', child: SortDropdown()),
          ],
        ),
      ),
    );
  }
}
