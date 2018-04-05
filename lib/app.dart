/// Flutter Packages
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

/// Personal Packages
import 'package:anniversary/widgets/store_widget.dart';
import 'package:anniversary/reducers/update_time_reducer.dart';
import 'package:anniversary/pages/home_page.dart';
import 'package:anniversary/themes/iOS_theme.dart';

class AnniversaryApp extends StatelessWidget {
  /// Attributes
  final String title;
  final DateTime anniversary;

  /// Constructors
  const AnniversaryApp({
    this.title,
    this.anniversary,
  });

  /// Widgets
  @override
  Widget build(BuildContext context) {
    return new StoreInheritedWidget(
      title: this.title,
      anniversary: this.anniversary,
      store: new Store<DateTime>(updateTimeReducer, initialState: updateTime(anniversary)),
      child: new MaterialApp(
          title: this.title,
          theme: kIOSTheme,
          home: new AnniversaryHomePage(
            refreshRate: const Duration(seconds: 5),
          ),
      )
    );
  }
}
