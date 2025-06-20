import 'package:flutter/material.dart';

class SearchBarSection extends StatelessWidget {
  const SearchBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.all(12.0),
      child: const SearchBar(
        // remove shadow
        elevation: WidgetStatePropertyAll(0),

        constraints: BoxConstraints(maxWidth: 500),
        hintText: 'Search',
        leading: Icon(Icons.search_outlined),
      ),
    );
  }
}
