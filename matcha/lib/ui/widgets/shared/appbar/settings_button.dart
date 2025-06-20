import 'package:flutter/material.dart';

import 'package:matcha/ui/views/settings/settings_view.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings_outlined),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return const Dialog(child: SettingsView());
          },
        );
      },
    );
  }
}
