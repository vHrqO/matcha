import 'package:flutter/material.dart';

import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcnui;

class TagSelectTile extends StatefulWidget {
  const TagSelectTile({
    super.key,
    required this.currentTags,
    required this.availableSuggestTags,
    required this.tagsHasChanged,
  });

  final List<String> currentTags;
  final List<String> availableSuggestTags;

  final void Function(List<String> currentTags) tagsHasChanged;

  @override
  State<TagSelectTile> createState() => _TagSelectTileState();
}

class _TagSelectTileState extends State<TagSelectTile> {
  List<String> _suggestTags = [];
  List<String> _availableSuggestTags = [];

  List<String> _currentTags = [];

  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // prevent modify the "final" widget.currentTags
    _currentTags = List.of(widget.currentTags);

    _availableSuggestTags = widget.availableSuggestTags;

    // suggest callback
    _textController.addListener(() {
      setState(() {
        final value = _textController.text;
        if (value.isNotEmpty) {
          _suggestTags = _availableSuggestTags.where((element) {
            return element.startsWith(value);
          }).toList();
        } else {
          _suggestTags = _availableSuggestTags;
        }
      });
    });
  }

  @override
  void didUpdateWidget(covariant TagSelectTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentTags != widget.currentTags) {
      setState(() {
        // prevent modify the "final" widget.currentTags
        _currentTags = List.of(widget.currentTags);
      });
    }

    if (oldWidget.availableSuggestTags != widget.availableSuggestTags) {
      setState(() {
        _availableSuggestTags = widget.availableSuggestTags;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return shadcnui.Theme(
      data: shadcnui.ThemeData(
        colorScheme: shadcnui.ColorSchemes.darkNeutral(),
        radius: 0.5,
      ),
      child: shadcnui.ChipInput<String>(
        controller: _textController,

        // when add a tag
        onSubmitted: (value) {
          setState(() {
            _currentTags.add(value);
            widget.tagsHasChanged(_currentTags);
            _suggestTags.clear();
            _textController.clear();
          });
        },

        // when remove a tag
        onChanged: (value) {
          setState(() {
            _currentTags = value;
            widget.tagsHasChanged(_currentTags);
          });
        },

        // suggestions to show
        suggestions: _suggestTags,

        // when suggestion is choosen
        onSuggestionChoosen: (index) {
          setState(() {
            _currentTags.add(_suggestTags[index]);
            widget.tagsHasChanged(_currentTags);
            _textController.clear();
          });
        },

        chips: _currentTags,
        chipBuilder: (context, chip) {
          return Text(chip);
        },
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
