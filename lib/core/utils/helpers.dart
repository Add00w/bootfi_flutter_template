import '../../generated/I10n/app_localizations.dart';

Iterable<String> supportedLanguages() {
  String _codeToLanguage(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'ar':
        return 'عربي';
      default:
        return 'English';
    }
  }

  final supportedLanguages = AppLocalizations.supportedLocales
      .map((locale) => _codeToLanguage(locale.languageCode));
  return supportedLanguages;
}
