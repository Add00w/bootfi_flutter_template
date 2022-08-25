import 'package:flutter/widgets.dart' show Locale;
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show Reader, StateNotifier, StateNotifierProvider, StateProvider;

import '../../../core/core.dart';
import '../settings.dart';

class LocaleNotifier extends StateNotifier<Locale?> {
  LocaleNotifier(this._read) : super(null);

  final Reader _read;

  void changeLocale(Locale locale) async {
    final settingsRepo = _read(settingsRepoProvider);
    final localeSaved = await settingsRepo.setLocale(locale);
    if (localeSaved) {
      state = locale;
    }
  }

  void defaultToDeviceLocale(Locale? locale) {
    if (locale == null) return;
    state = state ?? locale;
    _read(selectedLocaleProvider.notifier).state = state;
    changeLocale(locale);
  }

  void getLocale() async {
    state = state ?? await _read(settingsRepoProvider).getLocale();
    _read(selectedLocaleProvider.notifier).state = state;
  }
}

final isLocaleArProvider = StateProvider<bool>((ref) {
  return ref.watch(currentLocaleProvider)?.languageCode == 'ar';
});
final currentLocaleProvider =
    StateNotifierProvider<LocaleNotifier, Locale?>((ref) {
  return LocaleNotifier(ref.read);
});
final selectedLocaleProvider = StateProvider<Locale?>((ref) {
  return null;
});
final supportedLanguagesProvider = StateProvider<Iterable<String>>((ref) {
  return supportedLanguages();
});
