import 'dart:ui' show Locale;

import '../../generated/l10n/app_localizations.dart';

String codeToLanguage(String code) {
  switch (code) {
    case 'en':
      return 'English';
    case 'ar':
      return 'عربي';
    default:
      return 'English';
  }
}

Iterable<String> supportedLanguages() {
  final supportedLanguages = AppLocalizations.supportedLocales
      .map((locale) => codeToLanguage(locale.languageCode));
  return supportedLanguages;
}

Locale languageToLocale(String language) {
  String languageToCode(String language) {
    switch (language) {
      case 'عربي':
        return 'ar';
      default:
        return 'en';
    }
  }

  return Locale(languageToCode(language));
}
