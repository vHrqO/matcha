import 'package:flutter/material.dart';
import 'package:matcha/app/constants.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class SortDropdownButton extends StatefulWidget {
  const SortDropdownButton({
    super.key,
    required this.initialSelection,
    this.onSelected,
  });

  final SortOrder initialSelection;

  final void Function(SortOrder sortOrder)? onSelected;

  @override
  State<SortDropdownButton> createState() => _SortDropdownButtonState();
}

class _SortDropdownButtonState extends State<SortDropdownButton> {
  late SortOrder _sortOrder = widget.initialSelection;

  final MenuController _menuController = MenuController();

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      controller: _menuController,
      builder: (BuildContext context, MenuController controller, Widget? child) {
        return IconButton(
          iconSize: 20,
          icon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(FluentIcons.arrow_sort_20_regular, size: 20),
              const SizedBox(width: 4),
              Icon(FluentIcons.chevron_down_12_regular, size: 10),
            ],
          ),
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
        );
      },

      menuChildren: SortOrder.values.map((sortingMethod) {
        return MenuItemButton(
          leadingIcon: Icon(
            FluentIcons.checkmark_12_regular,
            size: 12,
            color: _sortOrder == sortingMethod ? null : Colors.transparent,
          ),
          child: Text(sortingMethod.uiName),
          onPressed: () {
            setState(() {
              _sortOrder = sortingMethod;
            });
            widget.onSelected?.call(_sortOrder);
          },
        );
      }).toList(),
    );
  }
}
