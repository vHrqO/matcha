import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matcha/repository/tab_group_repo.dart';

import 'package:matcha/ui/views/home_view.dart';
import 'package:matcha/view_model/settings/appearance_viewmodel.dart';
import 'package:matcha/view_model/shared/app_viewmodel.dart';
import 'package:matcha/view_model/shared/database_viewmodel.dart';
import 'package:matcha/view_model/shared/selected_viewmodel.dart';

class MatchaApp extends StatelessWidget {
  const MatchaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const _InitProvider(child: AppWidget());
  }
}

class _InitProvider extends ConsumerWidget {
  const _InitProvider({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // https://riverpod.dev/docs/essentials/eager_initialization#wont-this-rebuild-our-entire-application-when-the-provider-changes
    // Eagerly initialize providers by watching them.
    // By using "watch", the provider will stay alive and not be disposed.
    // and when use ref.invalidate ,a new state will be created.
    ref.watch(tabDbProvider);
    ref.watch(tabGroupRepoProvider);

    ref.watch(rightSideOpenedProvider);
    ref.watch(tabGroupOpenedProvider);

    ref.watch(selectedTabsItemProvider);
    ref.watch(selectedTabGroupProvider);
    ref.watch(selectedSessionIdProvider);
    ref.watch(selectedWindowIdProvider);

    //
    return child;
  }
}

class AppWidget extends ConsumerWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(appThemeModeProvider);

    return MaterialApp(
      title: 'Matcha',

      // remove debug Banner
      debugShowCheckedModeBanner: false,

      themeMode: switch (themeModeAsync) {
        AsyncData(value: final themeMode) => themeMode,
        _ => ThemeMode.system,
      },
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),

      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      // ),
      home: const HomeView(),
    );
  }
}
// 
// 