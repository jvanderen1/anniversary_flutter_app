/// Filename: list_unit_widget.dart
///
/// Description:
/// Displays a unit of time.
///
/// Updated: 04.16.2018

/// Flutter Packages
import 'package:flutter/material.dart';

class ListUnitWidget extends StatelessWidget {
  /// Attributes
  final String timeUnit;

  /// Constructors
  const ListUnitWidget({
    this.timeUnit
  });

  /// Widgets
  @override
  Widget build(BuildContext context) {
    return new Text(
      this.timeUnit,
      textAlign: TextAlign.right,
      style: const TextStyle(fontSize: 30.0),
    );
  }
}