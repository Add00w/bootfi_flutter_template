import 'package:bootfi_flutter_template/core/config/app_config.dart';
import 'package:flutter/foundation.dart' show kReleaseMode, debugPrint;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show ProviderContainer, UncontrolledProviderScope;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import './app.dart';
import './features/notifications/notifiers/notification_state_notifier.dart';
import 'core/constants/app_constants.dart' as app_constants;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Use debugPrint and not print to log in console
  //That will avoid printing in production mode
  //By using the below code
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

//Info for Sentry
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  String appName = packageInfo.appName;
  app_constants.appVersion = version;
//Use UncontrolledProvider instead ProviderScope to initialize
// some services at start.
  final container = ProviderContainer();
  // read the services you want to be pre-initialized
  container.read(notificationsStateNotifierProvider);
  final config = await container.read(configurationsProvider.future);
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
