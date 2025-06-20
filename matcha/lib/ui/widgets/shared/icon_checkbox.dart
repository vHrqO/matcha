import 'package:flutter/material.dart';

class IconCheckbox extends StatefulWidget {
  const IconCheckbox({
    super.key,
    required this.icon,
    required this.value,
    this.onChanged,
  });

  final Icon icon;

  final bool value;
  final void Function(bool? value)? onChanged;

  @override
  State<IconCheckbox> createState() => _IconCheckboxState();
}

class _IconCheckboxState extends State<IconCheckbox> {
  bool _checkboxVisible = false;
  bool _hoverOnCheckbox = false;

  @override
  Widget build(BuildContext context) {
    if (widget.value || _hoverOnCheckbox) {
      _checkboxVisible = true;
    } else {
      _checkboxVisible = false;
    }

    return MouseRegion(
      onHover: (event) {
        setState(() {
          _hoverOnCheckbox = true;
        });
      },
      onExit: (event) {
        setState(() {
          _hoverOnCheckbox = false;
        });
      },
      child: SizedBox(
        height: 24,
        width: 24,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // to_do: add animation
            Visibility(visible: !_checkboxVisible, child: widget.icon),

            // to_do: add animation
            Visibility(
              visible: _checkboxVisible,
              child: Checkbox(value: widget.value, onChanged: widget.onChanged),
            ),
          ],
        ),
      ),
    );
  }
}
