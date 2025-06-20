import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:matcha/view_model/tab_manager/session_content_section/session_content_viewmodel.dart';

class StatusBar extends ConsumerWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusBarText = ref.watch(statusBarTextProvider);

    return Container(
      padding: EdgeInsets.all(4.0),
      height: 30,
      child: Text(statusBarText),
    );
  }
}
