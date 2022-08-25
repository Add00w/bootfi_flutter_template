import 'package:hooks_riverpod/hooks_riverpod.dart' show StateProvider;

final authProvider = StateProvider<bool>((ref) {
  return false;
});
