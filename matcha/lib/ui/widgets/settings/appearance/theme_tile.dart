import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:matcha/view_model/settings/appearance_viewmodel.dart';

class ThemeTile extends ConsumerWidget {
  const ThemeTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(appThemeModeProvider);

    return ListTile(
      leading: Icon(Icons.color_lens_outlined),
      title: Text('Theme'),
      subtitle: switch (themeModeAsync) {
        AsyncData(value: final themeMode) => ThemeModeChoice(selection: themeMode),
        _ => const Skeletonizer(child: ThemeModeChoice(selection: ThemeMode.system)),
      },
    );
  }
}

class ThemeModeChoice extends ConsumerWidget {
  const ThemeModeChoice({super.key, required this.selection});

  final ThemeMode selection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SegmentedButton(
      segments: const [
        ButtonSegment<ThemeMode>(value: ThemeMode.system, label: Text('System')),
        ButtonSegment<ThemeMode>(value: ThemeMode.light, label: Text('Light')),
        ButtonSegment<ThemeMode>(value: ThemeMode.dark, label: Text('Dark')),
      ],
      selected: <ThemeMode>{selection},
      onSelectionChanged: (Set<ThemeMode> newSelection) {
        ref.read(appThemeModeProvider.notifier).setThemeMode(newSelection.first);
      },
    );
  }
}
