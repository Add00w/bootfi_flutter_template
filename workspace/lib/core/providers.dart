import 'package:hooks_riverpod/hooks_riverpod.dart';

// To change the server use
// ref.read(serverProvider.notifier).state = 'prod';
// Use 'prod', 'dev', or 'testing'
final serverProvider = StateProvider<String>((ref) {
  return 'dev';
});
