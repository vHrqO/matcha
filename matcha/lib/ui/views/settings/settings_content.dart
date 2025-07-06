import 'package:flutter/material.dart';
import 'package:matcha/ui/widgets/settings/appearance/appearance_section.dart';

class SettingsContent extends StatefulWidget {
  const SettingsContent({super.key});

  @override
  State<SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          extended: true,
          labelType: NavigationRailLabelType.none,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
          minExtendedWidth: 200,

          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },

          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.color_lens_outlined),
              label: Text('Appearance'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.storage_outlined),
              label: Text('Data'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.cloud_outlined),
              label: Text('Sync'),
            ),
            NavigationRailDestination(icon: Icon(Icons.info), label: Text('About')),
          ],
        ),

        // content for the selected
        Expanded(
          child: Card(
            child: switch (_selectedIndex) {
              0 => const AppearanceSection(),
              1 => Text('Data', style: Theme.of(context).textTheme.headlineSmall),
              2 => Text(
                'Sync Settings',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              3 => Text('About', style: Theme.of(context).textTheme.headlineSmall),
              _ => const Placeholder(),
            },
          ),
        ),
      ],
    );
  }
}
