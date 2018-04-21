/// Filename: store_widget.dart
///
/// Description:
/// Holds data useful across all widget layers, including a title [String],
/// a [Store], and a [SharedPreferences].
///
/// Updated: 04.16.2018

/// Flutter Packages
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreInheritedWidget extends InheritedWidget {
  /// Attributes
  final Store<DateTime> store;
  final String title;
  final SharedPreferences prefs;

  /// Constructors
  const StoreInheritedWidget({
    Key key,
    this.title,
    this.store,
    this.prefs,
    Widget child,
  }) :  assert(title != null),
        assert(store != null),
        assert(prefs != null),
        super(key: key, child: child);

  /// Methods
  static StoreInheritedWidget of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(StoreInheritedWidget);

  /// Widget Methods
  @override
  bool updateShouldNotify(StoreInheritedWidget old) => true;
}