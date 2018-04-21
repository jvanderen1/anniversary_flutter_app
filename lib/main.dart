/// Filename: main.dart
///
/// Description:
/// Creates an [AnniversaryApp]
///
/// Updated: 04.20.2018

/// Flutter Packages
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Dart Packages
import 'dart:async';

/// Personal Packages
import 'package:anniversary/app.dart';

Future<Null> main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(new AnniversaryApp(
    title: 'Anniversary',
    prefs: prefs,
  ));
}
