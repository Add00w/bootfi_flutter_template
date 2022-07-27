import 'package:flutter/material.dart';

import '../../generated/I10n/app_localizations.dart';

extension LocaleExtension on BuildContext {
  AppLocalizations get locale => AppLocalizations.of(this);
}

extension ScreenSizeExtension on BuildContext {
  Size get size => MediaQuery.of(this).size;
}

extension AppThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}
