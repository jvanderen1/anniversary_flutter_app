/// Filename: home_page.dart
///
/// Description:
/// Displays information about the amount of time between
/// the current time and the anniversary time.
///
/// The time units are provided by a [StatelessWidget] called [ListUnitWidget].
/// The time values are provided by a [StatefulWidget] called [ListTimeWidget].
/// On every [AnniversaryHomePage.refreshRate], the [Store] is dispatched to
/// look for a new time difference between now and [anniversaryDate].
///
/// Updated: 04.20.2018

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
import 'package:anniversary/widgets/change_date_and_time_widget.dart';

class AnniversaryHomePage extends StatefulWidget {
  /// Attributes
  final Duration refreshRate;

  /// Constructors
  const AnniversaryHomePage({
    Key key,
    this.refreshRate: const Duration(minutes: 1),
  }) : super(key: key);


  /// Widget Methods
  @override
  _AnniversaryHomePageState createState() => new _AnniversaryHomePageState();
}

class _AnniversaryHomePageState extends State<AnniversaryHomePage> {
  /// Attributes
  Timer _timer;

  /// Methods

  /// Used to grab anniversary time from [StoreInheritedWidget.prefs] and push changes.
  void _updateDisplayTime(StoreInheritedWidget inheritedWidget) {
    final String anniversaryString = inheritedWidget.prefs.getString('anniversaryDate');
    inheritedWidget.store.dispatch(DateTime.parse(anniversaryString));
  }

  /// Used to grab the stored data within [SharedPreferences].
  void _checkAndGrabData(StoreInheritedWidget inheritedWidget) {
    String anniversaryString = inheritedWidget.prefs.getString('anniversaryDate');

    if (anniversaryString == null) {
      /// An Easter egg anniversary date, upon first installation.
      inheritedWidget.prefs.setString('anniversaryDate', DateTime(1997, 2, 12).toString());
      anniversaryString = inheritedWidget.prefs.getString('anniversaryDate');
    }

    inheritedWidget.store.dispatch(DateTime.parse(anniversaryString));
  }

  /// Calls a [ChangeDateAndTimeWidget] to select both a date and time.
  Future<Null> _selectDateAndTime(BuildContext context, StoreInheritedWidget inheritedWidget) async {
    final String anniversaryString = inheritedWidget.prefs.getString('anniversaryDate');
    final DateTime storedDateTime = DateTime.parse(anniversaryString);

    DateTime selectedDateTime = await showDialog<DateTime>(
        context: context,
        builder: (BuildContext context) => new ChangeDateAndTimeWidget(startDateTime: storedDateTime)
    );

    if (selectedDateTime != null) {
      inheritedWidget.prefs.setString('anniversaryDate', selectedDateTime.toString());
      inheritedWidget.store.dispatch(selectedDateTime);
    }
  }

  /// Platform-Specific Widgets

  /// Android Platform
  AppBar _createAppBar(BuildContext context, StoreInheritedWidget inheritedWidget) {
    return new AppBar(
      title: new Text(inheritedWidget.title),
      actions: <Widget>[
        new IconButton(
            icon: new Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () => _selectDateAndTime(context, inheritedWidget)
        ),
      ],
    );
  }

  /// iOS Platform
  CupertinoNavigationBar _createCupertinoNavigationBar(BuildContext context, StoreInheritedWidget inheritedWidget) {
    return new CupertinoNavigationBar(
      middle: new Text(inheritedWidget.title),
      trailing: new CupertinoButton(
          child: new Icon(
            Icons.settings,
            color: CupertinoColors.black,
          ),
          onPressed: () => _selectDateAndTime(context, inheritedWidget)
      ),
    );
  }

  /// Widget Methods
  @override
  Widget build(BuildContext context) {

    final inheritedWidget = StoreInheritedWidget.of(context);

    this._checkAndGrabData(inheritedWidget);

    WidgetsBinding.instance.addObserver(
      new AppResumeHandler(
        resumeCallBack: () => _updateDisplayTime(inheritedWidget),
      ),
    );

    this._timer = new Timer.periodic(widget.refreshRate, (Timer timer) =>
        _updateDisplayTime(inheritedWidget));

    return new StoreProvider<DateTime>(
      store: inheritedWidget.store,
      child: new MaterialApp(
        title: inheritedWidget.title,
        theme: Theme.of(context),
        home: new Scaffold(
          appBar: Theme.of(context).platform == TargetPlatform.iOS
              ? _createCupertinoNavigationBar(context, inheritedWidget)
              : _createAppBar(context, inheritedWidget),
          body: new Center(
            child: new ListView(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),

              children: ['years', 'months', 'days', 'hours', 'minutes'].map((timeUnit) =>
              new Row(
                children: <Widget>[
                  new Expanded(
                      child: Row(
                        children: <Widget>[
                          new ListTimeWidget(timeUnit: timeUnit, isTensDigit: true),
                          new ListTimeWidget(timeUnit: timeUnit, isTensDigit: false),
                        ],
                      )
                  ),
                  new Expanded(
                    child: new ListUnitWidget(timeUnit: timeUnit),
                  ),
                ],
              )).toList(),
            ),
          ),
        ),
      ),
    );
  }

  /// Cancel [_timer], so resources aren't being used.
  @override
  void dispose() {
    this._timer.cancel();
    super.dispose();
  }
}

/// Helper class called when the app resumes.
class AppResumeHandler extends WidgetsBindingObserver {
  /// Attributes
  final resumeCallBack;

  /// Constructors
  AppResumeHandler({
    this.resumeCallBack,
  });

  /// Widget Methods
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed)
      resumeCallBack();
  }
}
