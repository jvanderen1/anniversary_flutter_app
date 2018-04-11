/// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/cupertino.dart';

/// Dart Packages
import 'dart:async';

/// Personal Packages
import 'package:anniversary/widgets/list_time_widget.dart';
import 'package:anniversary/widgets/list_unit_widget.dart';
import 'package:anniversary/widgets/store_widget.dart';

class AnniversaryHomePage extends StatelessWidget {
  /// Attributes
  final Duration refreshRate;

  /// Constructors
  const AnniversaryHomePage({
    Key key,
    this.refreshRate: const Duration(minutes: 1),
  }) : super(key: key);

  /// Widgets
  @override
  Widget build(BuildContext context) {
    final inheritedWidget = StoreInheritedWidget.of(context);

    new Timer.periodic(this.refreshRate, (Timer timer) async {
      inheritedWidget.store.dispatch(inheritedWidget.anniversary);
    });

    return new StoreProvider<DateTime>(
      store: inheritedWidget.store,
      child: new MaterialApp(
        title: inheritedWidget.title,
        theme: Theme.of(context),
        home: new Scaffold(
          appBar: Theme.of(context).platform == TargetPlatform.iOS
              ? createCupertinoNavigationBar(inheritedWidget)
              : createAppBar(inheritedWidget),
          body: new Center(
            child: new ListView(
              padding: new EdgeInsets.only(left: 20.0, right: 20.0),

              // TODO: (Maybe) Change the list to be a parameter instead
              children: ['years', 'months', 'days', 'hours', 'minutes'].map((timeUnit) =>
              new Row(
                children: <Widget>[
                  new ListTimeWidget(timeUnit: timeUnit),
                  new ListUnitWidget(timeUnit: timeUnit),
                ],
              )).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

createAppBar(inheritedWidget) =>
  new AppBar(
    title: new Text(inheritedWidget.title),
    actions: <Widget>[
      new IconButton(
          icon: new Icon(
            Icons.settings,
            color: Colors.black,
          ),
          onPressed: null),
    ],
  );

createCupertinoNavigationBar(inheritedWidget) =>
    new CupertinoNavigationBar(
      middle: new Text(inheritedWidget.title),
      trailing: new IconButton(
          icon: new Icon(
            Icons.settings,
            color: CupertinoColors.black,
          ),
          onPressed: null
      ),
    );