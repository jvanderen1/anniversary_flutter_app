/// Filename: app.dart
///
/// Description:
/// Used to create a store for anniversary information and start the home page.
///
/// While [FutureBuilder] gathers the needed [SharedPreferences], an empty
/// [Container] will be provided. Once complete, a new [StoreInheritedWidget]
/// is created and the starting page leads to [AnniversaryHomePage].
///
/// Updated: 04.20.2018

/// Flutter Packages
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Personal Packages
import 'package:anniversary/widgets/store_widget.dart';
import 'package:anniversary/reducers/update_time_reducer.dart';
import 'package:anniversary/pages/home_page.dart';
import 'package:anniversary/themes/app_theme.dart' show appTheme;

class AnniversaryApp extends StatelessWidget {
  /// Attributes
  final String title;
  final SharedPreferences prefs;

  /// Constructors
  const AnniversaryApp({
    this.title,
    this.prefs
  });

  /// Widget Methods
  @override
  Widget build(BuildContext context) {
    return new StoreInheritedWidget(
        title: this.title,
        store: new Store<DateTime>(updateTimeReducer),
        prefs: this.prefs,
        child: new MaterialApp(
          title: this.title,
          home: new AnniversaryHomePage(refreshRate: const Duration(seconds: 10),),
          theme: appTheme,
        )
    );
  }
}
