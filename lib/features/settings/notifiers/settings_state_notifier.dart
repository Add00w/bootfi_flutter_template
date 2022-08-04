import 'dart:ui' show Locale;

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utils/helpers.dart';

final currentLocaleProvider = StateProvider<Locale?>((ref) {
  return null;
});
final supportedLanguagesProvider = StateProvider<Iterable<String>>((ref) {
  return supportedLanguages();
});
