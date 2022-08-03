import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utils/helpers.dart';

final selectedLanguageProvider = StateProvider<String>((ref) {
  return '';
});
final languagesProvider = StateProvider<Iterable<String>>((ref) {
  return supportedLanguages();
});
