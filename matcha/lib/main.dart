import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:matcha/app/app.dart';

void main() {
  runApp(
    // Riverpod
    const ProviderScope(child: MatchaApp()),
  );
}
