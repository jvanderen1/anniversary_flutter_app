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

    // TODO: Attempt to place text on bottom of list
    return new Expanded(
      child: new Text(
        this.timeUnit,
        textAlign: TextAlign.right,
        style: new TextStyle(fontSize: 30.0),
      ),
    );
  }
}