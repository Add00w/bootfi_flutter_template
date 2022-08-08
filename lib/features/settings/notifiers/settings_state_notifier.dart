import 'dart:ui' show Locale;

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:hooks_riverpod/hooks_riverpod.dart' show StateProvider;

import '../../../core/utils/helpers.dart';

final currentLocaleProvider = StateProvider<Locale?>((ref) {
  debugPrint('in current locale');
  return null;
});
final selectedLocaleProvider = StateProvider<Locale?>((ref) {
  final currentLocale = ref.watch(currentLocaleProvider);
  debugPrint('in selected locale');
  return currentLocale;
});
final supportedLanguagesProvider = StateProvider<Iterable<String>>((ref) {
  return supportedLanguages();
});
