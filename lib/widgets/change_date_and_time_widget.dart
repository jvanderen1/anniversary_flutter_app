/// Filename: change_date_and_time_widget.dart
///
/// Description:
/// Dialog used to select a value for a new [anniversaryDate].
///
/// A provided [SimpleDialog] will end up calling [showDatePicker] to select a
/// Date and [showTimePicker] to select a time.
///
/// Updated: 04.20.2018

/// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Dart Packages
import 'dart:async';

class ChangeDateAndTimeWidget extends StatefulWidget {
  /// Attributes
  final DateTime startDateTime;

  /// Constructors
  const ChangeDateAndTimeWidget({
    this.startDateTime
  });

  @override
  _ChangeDateAndTimeWidgetState createState() => new _ChangeDateAndTimeWidgetState();
}

class _ChangeDateAndTimeWidgetState extends State<ChangeDateAndTimeWidget> {

  /// Attributes
  DateTime currentDateTime;
  TimeOfDay currentTimeOfDay;

  /// Methods

  /// Used to call [showTimePicker] with specific parameters.
  Future<TimeOfDay> _selectTime(BuildContext context) async {

    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: this.currentTimeOfDay
    );

    return picked;
  }

  /// Used to call [showDatePicker] with specific parameters.
  Future<DateTime> _selectDate(BuildContext context) async {

    /// Check for if user changes the device's clock.
    final initialDate = DateTime.now().isBefore(this.currentDateTime) ?
        DateTime.now() :
        this.currentDateTime;

    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: new DateTime(0, 0),
      lastDate: new DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
    );

    return picked;
  }

  /// Used to get the DateTime from both the [currentDateTime] and [currentTimeOfDay].
  DateTime _getNewAnniversaryDateTime() {
    return new DateTime(
        this.currentDateTime.year,
        this.currentDateTime.month,
        this.currentDateTime.day,
        this.currentTimeOfDay.hour,
        this.currentTimeOfDay.minute
    );
  }

  /// Platform-Specific Widgets

  /// Android Platform
  RaisedButton _createRaisedButton() {
    return new RaisedButton(
        child: const Text ('Confirm'),
        onPressed: () {
          DateTime newAnniversaryDateTime = this._getNewAnniversaryDateTime();
          Navigator.pop(context, newAnniversaryDateTime);
        });
  }

  /// iOS Platform
  CupertinoButton _createCupertinoButton() {
    return new CupertinoButton(
        child: const Text ('Confirm'),
        onPressed: () {
          DateTime newAnniversaryDateTime = this._getNewAnniversaryDateTime();
          Navigator.pop(context, newAnniversaryDateTime);
        });
  }

  /// Widgets
  @override
  void initState() {
    super.initState();

    this.currentDateTime = widget.startDateTime;
    this.currentTimeOfDay = new TimeOfDay.fromDateTime(this.currentDateTime);
  }

  @override
  Widget build(BuildContext context) => new SimpleDialog(
      title: const Text('Anniversary Date and Time', style: const TextStyle(fontSize: 17.5)),
      children: <Widget>[
        new SimpleDialogOption(
            child: new Row(
              children: <Widget>[
                new Expanded(
                    child: const Text('Date:')
                ),
                new Expanded(
                    child: new FlatButton(
                      child: new Text(
                        "${this.currentDateTime.month.toString().padLeft(2, '0')} / ${this.currentDateTime.day.toString().padLeft(2, '0')} / ${this.currentDateTime.year.toString().padLeft(4, '0')}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12.0),
                      ),
                      onPressed: () {
                        _selectDate(context).then((newDateTime) {
                          setState(() {
                            this.currentDateTime = newDateTime ?? this.currentDateTime;
                          });
                        });
                      },
                    )
                ),
              ],
            )
        ),
        new SimpleDialogOption(
            child: new Row(
              children: <Widget>[
                new Expanded(
                    child: const Text('Time:')
                ),
                new Expanded(
                    child: new FlatButton(
                      child: new Text(
                        "${this.currentTimeOfDay.hour.toString().padLeft(2, '0')} : ${this.currentTimeOfDay.minute.toString().padLeft(2, '0')}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12.0),
                      ),
                      onPressed: () {
                        _selectTime(context).then((newTimeOfDay) {
                          setState(() {
                            this.currentTimeOfDay = newTimeOfDay ?? this.currentTimeOfDay;
                          });
                        });
                      },
                    )
                ),
              ],
            )
        ),
        new SimpleDialogOption(
          child: Theme.of(context).platform == TargetPlatform.iOS
              ? _createCupertinoButton()
              : _createRaisedButton(),
        ),
      ],
    );
}
