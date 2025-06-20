import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      height: MediaQuery.of(context).size.height * 0.55,
      padding: const EdgeInsets.all(16.0),

      child: Column(
        children: [
          // appbar
          Row(
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
          ),

          // content
          Expanded(
            child: Row(
              children: [
                NavigationRail(
                  extended: true,
                  labelType: NavigationRailLabelType.none,
                  backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                  minExtendedWidth: 200,

                  selectedIndex: 0,
                  onDestinationSelected: (int index) {
                    // Handle navigation here
                  },

                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.cloud_outlined),
                      label: Text('Sync'),
                    ),

                    NavigationRailDestination(
                      icon: Icon(Icons.info),
                      label: Text('About'),
                    ),
                  ],
                ),

                // Example content for the selected page
                Expanded(
                  child: Card(
                    child: Center(
                      child: Text(
                        'Select a setting from the navigation rail.',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
