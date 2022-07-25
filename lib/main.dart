import 'package:flutter/foundation.dart' show kReleaseMode, debugPrint;
import 'package:flutter/material.dart' show runApp;

import './app.dart';

void main() {
  //Use debugPrint and not print to log in console
  //That will avoid printing in production mode
  //By using the below code
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }
  runApp(const App());
}
