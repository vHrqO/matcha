import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text('Opened Tabs', style: Theme.of(context).textTheme.titleMedium),

          Spacer(),

          // Tooltip(
          //   message: "Full screen",
          //   child: IconButton(
          //     padding: const EdgeInsets.all(0.0),
          //     icon: const Icon(Icons.fullscreen),
          //     onPressed: () {
          //       print("fullscreen");
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

//
