/// Filename: list_time_widget.dart
///
/// Description:
/// Displays the value of a provided time, given a unit.
///
/// Anytime this widget needs to be rebuilt, an [Animation] is triggered to
/// cause a flip animation.
///
/// Updated: 04.16.2018

/// Flutter Packages
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

/// Dart Packages
import 'dart:async';

class ListTimeWidget extends StatelessWidget {
  /// Attributes
  final String timeUnit;
  final bool isTensDigit;

  /// Constructors
  const ListTimeWidget({
    this.timeUnit,
    this.isTensDigit,
  });

  /// Methods

  /// Gathers correct time value, from the given [timeUnit]
  String _selectCorrectTime(Store<DateTime> store) {
    /// Function used to select proper time from time change.

    /// Only go here if the time value is incorrect.
    if (store.state == null) {
      return '##';
    }

    Map<String, int> timeDelta = {
      'years': store.state.year,
      'months': store.state.month,
      'days': store.state.day,
      'hours': store.state.hour,
      'minutes': store.state.minute,
    };

    /// Only returns map option if the time unit exists.
    if (timeDelta.containsKey(this.timeUnit)) {
      final displayTime = timeDelta[this.timeUnit];

      if (isTensDigit)
        return displayTime.toString().padLeft(2, '0')[0];
      else
        return displayTime.toString().padLeft(2, '0')[1];
    }
    else
      return '#';
  }

  /// Widget Methods
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<DateTime, String>(
      converter: (store) => this._selectCorrectTime(store),
      builder: (context, time) => new ListTimeWidgetAnimation(amountOfTime: time),
    );
  }
}

class ListTimeWidgetAnimation extends StatefulWidget {
  /// Attributes
  final String amountOfTime;

  /// Constructors
  const ListTimeWidgetAnimation({
    this.amountOfTime,
  });

  /// Widget Methods
  @override
  _ListTimeWidgetAnimationState createState() => new _ListTimeWidgetAnimationState();
}


class _ListTimeWidgetAnimationState extends State<ListTimeWidgetAnimation>
    with SingleTickerProviderStateMixin {

  /// Attributes
  Animation<double> _animation;
  AnimationController _controller;
  String _currentTime;

  /// Methods

  /// Creates an animation, in which the value disappears, changes,
  /// and reappears.
  Future<Null> _changeTimeAnimation() async {
    /// Function used to control the animation of a time change

    /// Flip current value back to nothing
    await this._controller.reverse();

    /// Change the state value of the time
    setState(() {
      this._currentTime = widget.amountOfTime;
    });

    /// Flip new value back to something
    await this._controller.forward();
  }

  /// Generates a flip animation [Transform].
  Transform _flipAnimation(Widget child) {

    const double tolerance = 0.000000000000000000000000000000000000000000001;

    final Matrix4 transform = new Matrix4.identity()
      ..scale(1.0 + tolerance, this._animation.value + tolerance);

    return Transform(
      transform: transform,
      alignment: FractionalOffset.center,
      child: child,
    );
  }

  /// Widget Methods
  @override
  void initState() {
    super.initState();

    this._controller = new AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    this._animation = new Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(new CurvedAnimation(
        parent: this._controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    ));

    this._currentTime = widget.amountOfTime;
    this._controller.forward();
  }

  @override
  Widget build(BuildContext context) {

    /// Only performs the animation when the value of the digit is different
    /// from the previous state.
    if (this._currentTime != widget.amountOfTime) {
      this._changeTimeAnimation();
    }

    return new AnimatedBuilder(
      animation: this._animation,
      builder: (BuildContext context, Widget child) => this._flipAnimation(child),
      child: new Text(
        this._currentTime,
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 100.0),
      ),
    );
  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }
}
