import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show ConsumerWidget, StateProvider, WidgetRef;

import './core/extensions/context_extensions.dart';
import './features/settings/notifiers/settings_state_notifier.dart';
import './generated/I10n/app_localizations.dart';
import '../features/notifications/presentaion/views/notifications_view.dart';
import '../features/settings/presentaion/views/settings_view.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('rebuilding the app');
    final currentLocaleNotifier = ref.watch(currentLocaleProvider.notifier);
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) => context.locale.appTitle,
      debugShowCheckedModeBanner: false,
      locale: ref.watch(currentLocaleProvider),
      localeResolutionCallback: (deviceLocal, supportedLocals) {
        // Start the app with the device's locale
        // if the user not selected language yet and
        // it is supported locale in our app
        debugPrint('In localeResolutionCallback');
        debugPrint('Selected locale:${currentLocaleNotifier.state}');
        debugPrint('Device locale:${deviceLocal?.languageCode}');

        if (currentLocaleNotifier.state == null &&
            supportedLocals.contains(deviceLocal)) {
          currentLocaleNotifier.state = deviceLocal;
        }
        return null;
      },
      builder: (_, child) => _Unfocus(child: child!),
      home: const _MainLayout(),
    );
  }
}

/// A widget that unfocus everything when tapped.
///
/// This implements the "Unfocus when tapping in empty space" behavior for the
/// entire application.
class _Unfocus extends StatelessWidget {
  const _Unfocus({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: child,
    );
  }
}

class _MainLayout extends ConsumerWidget {
  const _MainLayout({Key? key}) : super(key: key);
  static const _views = [SettingsView(), NotificationsView()];
  @override
  Widget build(BuildContext context, ref) {
    final activeTabNotifier = ref.read(activeTabProvider.notifier);
    final activeTab = ref.watch(activeTabProvider);
    return Scaffold(
      body: _views[activeTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: activeTab,
        onTap: (index) {
          activeTabNotifier.state = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            label: '',
          ),
        ],
      ),
    );
  }
}

final activeTabProvider = StateProvider<int>((ref) {
  return 0;
});
