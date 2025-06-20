import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class ClipBoardPopupButton extends StatefulWidget {
  const ClipBoardPopupButton({super.key});

  @override
  State<ClipBoardPopupButton> createState() => _ClipBoardPopupButtonState();
}

class _ClipBoardPopupButtonState extends State<ClipBoardPopupButton>
    with TickerProviderStateMixin {
  late FPopoverController controller = FPopoverController(vsync: this);

  @override
  Widget build(BuildContext context) {
    return FPopover(
      controller: controller,
      popoverAnchor: Alignment.topRight,
      childAnchor: Alignment.bottomRight,
      style: FPopoverStyle(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      ),
      child: ClipBoardButton(controller: controller),
      popoverBuilder: (context, style, child) {
        return ClipBoardPopup();
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class ClipBoardButton extends StatelessWidget {
  const ClipBoardButton({super.key, required this.controller});

  final FPopoverController controller;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(FluentIcons.clipboard_20_regular),
      //ClipboardBulletListLtrRegular
      isSelected: false,
      onPressed: () {
        controller.toggle();
      },
    );
  }
}

class ClipBoardPopup extends StatelessWidget {
  const ClipBoardPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 200,
      padding: const EdgeInsets.all(4.0),

      child: Material(
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: Column(children: [Text('clipboard')]),
      ),
    );
  }
}
