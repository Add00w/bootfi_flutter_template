import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './core/extensions/context_extensions.dart';
import './generated/I10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) => context.locale.appTitle,
      home: Scaffold(
        body: Column(
          children: [
            Text(context.locale.appTitle),
          ],
        ),
      ),
    );
  }
}
