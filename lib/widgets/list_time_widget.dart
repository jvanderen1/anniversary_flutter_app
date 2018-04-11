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

  /// Constructors
  const ListTimeWidget({
    this.timeUnit,
  });

  /// Methods
  String _selectCorrectTime(Store<DateTime> store) {
    /// Function used to select proper time from time change

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
      /// Return here when no valid time option is found
      return '##';
  }

  @override
  Widget build(BuildContext context) =>
      new Expanded(
          child: new StoreConnector<DateTime, String>(
            converter: (store) => this._selectCorrectTime(store),
            builder: (context, time) => new ListTimeWidgetAnimation(amountOfTime: time),
          )
      );
}

class ListTimeWidgetAnimation extends StatefulWidget {
  /// Attributes
  final String amountOfTime;

  /// Constructors
  const ListTimeWidgetAnimation({
    this.amountOfTime,
  });

  @override
  _ListTimeWidgetAnimationState createState() => new _ListTimeWidgetAnimationState();
}


class _ListTimeWidgetAnimationState extends State<ListTimeWidgetAnimation> with SingleTickerProviderStateMixin {

  /// Attributes
  Animation<double> _animation;
  AnimationController _controller;
  String _currentTime;

  /// Methods
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

  Transform _flipAnimation(Widget child) {
    /// Function used to generate a flip animation for the time

    final Matrix4 transform = new Matrix4.identity()
      ..scale(1.0, this._animation.value, 1.0);

    return Transform(
      transform: transform,
      alignment: FractionalOffset.center,
      child: child,
    );
  }

  /// Widgets
  @override
  void initState() {
    super.initState();

    this._controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    this._animation = new Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(this._controller);

    this._currentTime = widget.amountOfTime;
    this._controller.forward();
  }

  @override
  Widget build(BuildContext context) {

    if (this._currentTime != widget.amountOfTime) {
      this._changeTimeAnimation();
    }

    return new AnimatedBuilder(
      animation: this._animation,
      builder: (BuildContext context, Widget child) => this._flipAnimation(child),
      child: new Text(
        this._currentTime,
        textAlign: TextAlign.left,
        style: new TextStyle(fontSize: 100.0),
      ),
    );
  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }
}
