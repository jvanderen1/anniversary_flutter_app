/// Flutter Packages
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class StoreInheritedWidget extends InheritedWidget {
  /// Attributes
  final Store<DateTime> store;
  final String title;
  final DateTime anniversary;

  /// Constructors
  const StoreInheritedWidget({
    Key key,
    this.title,
    this.anniversary,
    this.store,
    Widget child,
  }) :  assert(title != null),
        assert(anniversary != null),
        assert(store != null),
        super(key: key, child: child);

  /// Methods
  static StoreInheritedWidget of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(StoreInheritedWidget);

  /// Widgets
  @override
  bool updateShouldNotify(StoreInheritedWidget old) =>
      (this.title != old.title) || (this.anniversary != old.anniversary);
}