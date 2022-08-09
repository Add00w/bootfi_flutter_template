import 'dart:ui' show Locale;

import 'package:hooks_riverpod/hooks_riverpod.dart' show StateProvider;

import '../../../core/core.dart';

final currentLocaleProvider = StateProvider<Locale?>((ref) {
  return null;
});
final selectedLocaleProvider = StateProvider<Locale?>((ref) {
  final currentLocale = ref.watch(currentLocaleProvider);
  return currentLocale;
});
final supportedLanguagesProvider = StateProvider<Iterable<String>>((ref) {
  return supportedLanguages();
});
