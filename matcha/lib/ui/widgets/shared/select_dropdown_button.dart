import 'package:flutter/material.dart';
import 'package:matcha/app/constants.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class SelectDropdownButton extends StatefulWidget {
  const SelectDropdownButton({super.key, this.onItemPressed});

  final void Function(SelectMethod selectMethod)? onItemPressed;

  @override
  State<SelectDropdownButton> createState() => _SelectDropdownButtonState();
}

class _SelectDropdownButtonState extends State<SelectDropdownButton> {
  final MenuController _menuController = MenuController();

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      controller: _menuController,
      builder: (BuildContext context, MenuController controller, Widget? child) {
        return IconButton(
          icon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(FluentIcons.multiselect_ltr_20_regular),
              const SizedBox(width: 4),
              Icon(FluentIcons.chevron_down_12_regular, size: 12),
            ],
          ),
          // disabled button if onItemPressed is null
          onPressed: (widget.onItemPressed == null)
              ? null
              : () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
        );
      },

      menuChildren: [
        MenuItemButton(
          leadingIcon: Icon(FluentIcons.select_all_on_20_regular),
          child: Text(SelectMethod.selectAll.uiName),
          onPressed: () {
            widget.onItemPressed?.call(SelectMethod.selectAll);
          },
        ),
        MenuItemButton(
          leadingIcon: Icon(FluentIcons.square_shadow_20_regular),
          child: Text(SelectMethod.invertSelection.uiName),
          onPressed: () {
            widget.onItemPressed?.call(SelectMethod.invertSelection);
          },
        ),
        MenuItemButton(
          leadingIcon: Icon(FluentIcons.select_all_off_20_regular),
          child: Text(SelectMethod.clearSelection.uiName),
          onPressed: () {
            widget.onItemPressed?.call(SelectMethod.clearSelection);
          },
        ),
      ],
    );
  }
}
