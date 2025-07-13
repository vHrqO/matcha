import 'package:flutter/material.dart';

import 'package:matcha/repository/settings_repo.dart';
import 'package:matcha/ui/views/appbar.dart';
import 'package:matcha/ui/views/app_content.dart';
import 'package:matcha/utils/prefs_helpers.dart' as prefs_helpers;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late final TabController _tabController;

  bool initFinished = false;

  @override
  void initState() {
    super.initState();

    _initApp();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(tabController: _tabController),

          AppContent(tabController: _tabController),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //
  void _initApp() async {
    final settingsRepo = SettingsRepo();

    if (await settingsRepo.isFirstTimeRun()) {
      // Show an Dialog for loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Loading...'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 24),
              Text('Initializing app settings...'),
            ],
          ),
        ),
      );

      // first time run, init preferences
      await prefs_helpers.initAllPrefs();

      // dummy code for the wait period
      // await Future.delayed(Duration(milliseconds: 5500));

      // close the dialog
      Navigator.of(context).pop();
    }

    // finish init
    setState(() {
      initFinished = true;
    });
  }
}
