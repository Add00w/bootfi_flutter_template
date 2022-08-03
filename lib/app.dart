import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show ConsumerWidget, HookConsumerWidget, StateProvider, WidgetRef;

import './core/extensions/context_extensions.dart';
import './generated/I10n/app_localizations.dart';
import '../features/notifications/presentaion/views/notifications_view.dart';
import '../features/settings/presentaion/views/settings_view.dart';

class App extends HookConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      localeResolutionCallback: (deviceLocal, supportedLocals) {
        // if (The user did not selected a language yet use the device locale) {
        //  set the locale to deviceLocal
        // }
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
