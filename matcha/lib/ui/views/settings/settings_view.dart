import 'package:flutter/material.dart';

import 'package:matcha/ui/views/settings/settings_content.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      height: MediaQuery.of(context).size.height * 0.55,
      padding: const EdgeInsets.all(16.0),

      child: Column(
        children: [
          TitleBar(),

          Expanded(child: SettingsContent()),
        ],
      ),
    );
  }
}

//
class TitleBar extends StatelessWidget {
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Settings', style: Theme.of(context).textTheme.titleMedium),

        const Spacer(),

        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
