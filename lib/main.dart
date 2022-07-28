import 'package:flutter/foundation.dart' show kReleaseMode, debugPrint;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show ProviderScope;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import './app.dart';
import 'core/constants/app_constants.dart' as app_constants;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Use debugPrint and not print to log in console
  //That will avoid printing in production mode
  //By using the below code
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  String appName = packageInfo.appName;
  app_constants.appVersion = version;

  if (app_constants.sentryDns.isEmpty) {
    runApp(
      const ProviderScope(
        child: App(),
      ),
    );
  } else {
    await SentryFlutter.init(
      (options) => options
        ..dsn = app_constants.sentryDns
        ..release = '$appName@$version'
        ..environment = app_constants.envName,
      appRunner: () => runApp(
        const ProviderScope(
          child: App(),
        ),
      ),
    );
  }
}
