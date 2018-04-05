/// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ListTimeWidget extends StatelessWidget {
  /// Attributes
  final String timeUnit;

  /// Constructors
  const ListTimeWidget({
    this.timeUnit
  });

  /// Methods
  String _selectCorrectTime(Store<DateTime> store) {
    Map<String, int> timeDelta = {
      'years': store.state.year,
      'months': store.state.month,
      'days': store.state.day,
      'hours': store.state.hour,
      'minutes': store.state.minute,
    };

    if (timeDelta.containsKey(this.timeUnit))
      return timeDelta[this.timeUnit].toString().padLeft(2, '0');
    else
      return '##';
  }

  /// Widgets
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<DateTime, String>(
      converter: (store) => this._selectCorrectTime(store),
      builder: (context, time) => new Expanded(
        child: new Text(
          time,
          textAlign: TextAlign.left,
          style: new TextStyle(fontSize: 100.0),
        ),
      ),
    );
  }
}
