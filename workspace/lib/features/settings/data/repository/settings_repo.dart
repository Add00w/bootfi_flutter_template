import 'package:flutter/widgets.dart' show Locale, debugPrint;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/core.dart';

class SettingsRepo {
  final Reader read;

  const SettingsRepo({required this.read});
  Future<bool> setLocale(Locale locale) async {
    final prefs = await read(sharedPreferencesProvider.future);
    return await prefs.setString(
        SharedPrefrenceKeys.locale.name, locale.toLanguageTag());
  }

  Future<Locale?> getLocale() async {
    final prefs = await read(sharedPreferencesProvider.future);
    final langTag = prefs.getString(SharedPrefrenceKeys.locale.name);
    debugPrint('language tag:>$langTag');
    Locale? locale;
    if (langTag != null) {
      locale = Locale(langTag);
    }
    return locale;
  }
}

final settingsRepoProvider = Provider<SettingsRepo>((ref) {
  return SettingsRepo(read: ref.read);
});
