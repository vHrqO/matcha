import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class LeftSideCard extends StatelessWidget {
  const LeftSideCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [Center(child: Text('development in progress'))]),
    );
  }
}
