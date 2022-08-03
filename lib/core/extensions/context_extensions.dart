import 'package:flutter/material.dart';

import '../../generated/I10n/app_localizations.dart';

extension ContextExtensions on BuildContext {
  AppLocalizations get locale => AppLocalizations.of(this);
  Size get screenSize => MediaQuery.of(this).size;
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
}
