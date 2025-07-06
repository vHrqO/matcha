import 'package:flutter/material.dart';

import 'package:matcha/ui/widgets/settings/appearance/theme_tile.dart';

class AppearanceSection extends StatelessWidget {
  const AppearanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ThemeTile(),

        // ListTile(
        //   leading: Icon(Icons.format_size),
        //   title: Text('Font Size'),
        //   subtitle: Text('Small / Medium / Large'),
        // ),
      ],
    );
  }
}
