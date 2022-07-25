import 'package:flutter/material.dart';

extension LocaleExtension on BuildContext {
  // AppLocalizations get loc => AppLocalizations.of(this)!;
}

extension ScreenSizeExtension on BuildContext {
  Size get size => MediaQuery.of(this).size;
}

extension AppThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}
