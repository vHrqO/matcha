import 'package:flutter/material.dart';


class SingleTextBoxDialog extends StatefulWidget {
  const SingleTextBoxDialog({
    super.key,
    required this.title,
    required this.labelText,
    required this.submitButtonText,
  });

  final String title;
  final String labelText;
  final String submitButtonText;

  @override
  State<SingleTextBoxDialog> createState() => _SingleTextBoxDialogState();
}

class _SingleTextBoxDialogState extends State<SingleTextBoxDialog> {
  late final TextEditingController _controller = TextEditingController();

  bool submitButton = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12.0),

          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: widget.labelText,
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                submitButton = value.isNotEmpty;
              });
            },
          ),
        ],
      ),
      actions: [
        FilledButton(
          child: Text(widget.submitButtonText),

          // Disable if text is empty
          onPressed: submitButton
              ? () {
                  if (_controller.text.isNotEmpty) {
                    Navigator.of(context).pop(_controller.text);
                  }
                }
              : null,
        ),
        OutlinedButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
