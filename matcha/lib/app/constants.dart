import 'package:flutter/widgets.dart';

//
enum SortOrder {
  custom("Custom"),
  ascending("Ascending"),
  descending("Descending");

  final String uiName;

  const SortOrder(this.uiName);
}

enum SelectMethod {
  selectAll("Select All"),
  invertSelection("Invert Selection"),
  clearSelection("Clear Selection");

  final String uiName;

  const SelectMethod(this.uiName);
}

class AnimationSettings {
  static const duration = Duration(milliseconds: 300);
  static const curve = Curves.easeInOutCubic;
}
