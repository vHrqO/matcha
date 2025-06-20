import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/ui/widgets/shared/icon_checkbox.dart';

class TabTile extends StatefulWidget {
  const TabTile({
    super.key,
    required this.tab,
    required this.hoverMenu,
    required this.isSelected,
    required this.onChanged,
  });

  final matcha_tab.Tab tab;

  final Widget hoverMenu;

  final bool isSelected;
  final void Function(bool? value) onChanged;

  @override
  State<TabTile> createState() => _TabTileState();
}

class _TabTileState extends State<TabTile> {
  bool _trailingVisible = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
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
          icon: const Icon(FluentIcons.earth_20_regular),
          value: widget.isSelected,
          onChanged: (value) {
            widget.onChanged(value);
          },
        ),
        title: Text(widget.tab.title),
        subtitle: Text(widget.tab.tagList?.join(', ') ?? ''),
        trailing: _trailingVisible ? widget.hoverMenu : null,
        onTap: () {},
      ),
    );
  }
}
