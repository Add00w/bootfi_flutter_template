import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;

import '../../features/settings/settings.dart';

final themeProvider = Provider<ThemeData>((ref) {
  if (ref.watch(isLocaleArProvider)) return _arTheme;
  return _enTheme;
});

final _enTheme = _theme('Roboto');

final _arTheme = _theme('Hacen Tunisia');

final _baseTheme = ThemeData.light();
ThemeData _theme(String fontFamily) => ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.green,
      textTheme: _baseTheme.textTheme.apply(
        fontFamily: fontFamily,
      ),
      primaryTextTheme: _baseTheme.primaryTextTheme.apply(
        fontFamily: fontFamily,
      ),
      colorScheme: _baseTheme.colorScheme.copyWith(
        primary: Colors.green,
        secondary: Colors.orange,
        background: Colors.white,
      ),
      appBarTheme: _baseTheme.appBarTheme.copyWith(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
    );
