import 'package:flutter/material.dart';

class BarItem {
  /// ber item icon which shown when item is inactive.
  final Widget widget;

  /// active color of the item, required when use SlidingClippedNavBar.coloredItems
  final Color? activeColor;

  /// inactiveColor color of the item, required when use SlidingClippedNavBar.coloredItems
  final Color? inactiveColor;

  /// ber item text which shown when item is active.
  final String title;
  BarItem({
    required this.title,
    required this.widget,
    this.activeColor,
    this.inactiveColor,
  });
}
