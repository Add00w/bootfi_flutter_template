import 'package:flutter/foundation.dart' show kReleaseMode, debugPrint;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show ProviderContainer, UncontrolledProviderScope;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import './app.dart';
import './core/core.dart';
import './features/notifications/notifications.dart';
import './features/settings/settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Use debugPrint and not print to log in console
  //That will avoid printing in production mode
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

//Info for Sentry
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  String appName = packageInfo.appName;
  appVersion = version;
//Use UncontrolledProvider instead ProviderScope to initialize
// some services at start.
  final container = ProviderContainer();
  // read the services you want to be pre-initialized
  container.read(notificationsStateNotifierProvider);
  final config = await container.read(configurationsProvider.future);
  container.read(currentLocaleProvider.notifier).getLocale();
  if (config.sentryDns.isEmpty) {
    runApp(
      UncontrolledProviderScope(
        container: container,
        child: const App(),
      ),
    );
  } else {
    await SentryFlutter.init(
      (options) => options
        ..dsn = config.sentryDns
        ..release = '$appName@$version'
        ..environment = config.envName,
      appRunner: () => runApp(
        UncontrolledProviderScope(
          container: container,
          child: const App(),
        ),
      ),
    );
  }
}
