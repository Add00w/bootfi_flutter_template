import 'package:flutter/material.dart';

import '../../generated/l10n/app_localizations.dart';

extension ContextExtensions on BuildContext {
  AppLocalizations get locale => AppLocalizations.of(this);
  Size get screenSize => MediaQuery.of(this).size;
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  // Use named or Navigator 2
  //So we don't need these extensions
  void push(Widget page) {
    Navigator.of(this).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  void pop() => Navigator.pop(this);
}
