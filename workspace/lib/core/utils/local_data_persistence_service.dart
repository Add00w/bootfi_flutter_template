import 'package:hooks_riverpod/hooks_riverpod.dart' show FutureProvider;
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  ref.onDispose(prefs.clear);
  return prefs;
});
