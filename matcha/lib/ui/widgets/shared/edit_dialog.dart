import 'package:flutter/material.dart';

class EditDialog extends StatelessWidget {
  const EditDialog({super.key, required this.title, this.content, this.actions});

  final String title;

  final Widget? content;

  final Widget? actions;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),

            // content
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              child: SingleChildScrollView(child: content),
            ),

            // actions
            Padding(padding: const EdgeInsets.all(16.0), child: actions),
          ],
        ),
      ),
    );
  }
}
