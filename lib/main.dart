/// Flutter Packages
import 'package:flutter/material.dart';

/// Personal Packages
import 'package:anniversary/app.dart';
import 'package:anniversary/time_we_met.dart' show timeWeMet;

void main() {
  runApp(new AnniversaryApp(
    title: 'Anniversary',
    anniversary: timeWeMet,
  ));
}

