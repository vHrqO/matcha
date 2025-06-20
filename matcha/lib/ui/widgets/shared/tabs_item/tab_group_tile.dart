import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;
import 'package:matcha/ui/widgets/shared/icon_checkbox.dart';
import 'package:matcha/view_model/shared/app_viewmodel.dart';
import 'package:matcha/view_model/shared/selected_viewmodel.dart';

class TabGroupTile extends ConsumerStatefulWidget {
  const TabGroupTile({
    super.key,
    required this.tabGroup,
    required this.hoverMenu,
    required this.isSelected,
    required this.onChanged,
  });

  final matcha_tab_group.TabGroup tabGroup;

  final Widget hoverMenu;

  final bool isSelected;
  final void Function(bool? value) onChanged;

  @override
  ConsumerState<TabGroupTile> createState() => _TabGroupTileState();
}

class _TabGroupTileState extends ConsumerState<TabGroupTile> {
  bool _trailingVisible = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _trailingVisible = true;
        });
      },
      onExit: (event) {
        setState(() {
          _trailingVisible = false;
        });
      },
      child: ListTile(
        leading: IconCheckbox(
          icon: const Icon(FluentIcons.app_folder_20_regular),
          value: widget.isSelected,
          onChanged: (value) {
            widget.onChanged(value);
          },
        ),

        title: Text(widget.tabGroup.title),
        subtitle: Text(widget.tabGroup.tagList?.join(', ') ?? ''),
        trailing: _trailingVisible ? widget.hoverMenu : null,
        onTap: () {
          if (ref.read(tabGroupOpenedProvider) &&
              !ref
                  .read(selectedTabGroupProvider.notifier)
                  .isSelected(widget.tabGroup)) {
            // if already opened but not selected, update only
            ref.read(selectedTabGroupProvider.notifier).setSelected(widget.tabGroup);
            return;
          }

          if (!ref
              .read(selectedTabGroupProvider.notifier)
              .isSelected(widget.tabGroup)) {
            // If not selected, update selected tab group
            ref.read(selectedTabGroupProvider.notifier).setSelected(widget.tabGroup);
          }

          ref.read(tabGroupOpenedProvider.notifier).toggle();
        },
      ),
    );
  }
}
