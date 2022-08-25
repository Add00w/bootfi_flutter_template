import 'package:flutter/cupertino.dart' show CupertinoSwitch;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show useTextEditingController;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/core.dart';

class AboutUsView extends HookConsumerWidget {
  const AboutUsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, ref) {
    final localUrlController = useTextEditingController();
    final developerOptionClicks =
        ref.watch(developerOptionClickCountProvider.notifier);
    final developerOptionIsEnabled = ref.watch(developerOptionIsOnProvider);
    final serverNotifier = ref.watch(serverProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.locale.aboutUs,
          style: context.textTheme.headline6,
        ),
        backgroundColor: context.theme.bottomAppBarColor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.locale.whoAreWe,
                style: TextStyle(
                  fontSize: context.screenSize.width * 0.06,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                context.locale.whoAreWeText,
                style: TextStyle(
                  fontSize: context.screenSize.width * 0.04,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                context.locale.ourApp,
                style: TextStyle(
                  fontSize: context.screenSize.width * 0.06,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                context.locale.ourAppText,
                style: TextStyle(
                  fontSize: context.screenSize.width * 0.04,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                context.locale.developedBy,
                style: TextStyle(
                  fontSize: context.screenSize.width * 0.06,
                ),
              ),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () {
                  developerOptionClicks.state++;
                },
                child: Center(
                  child: FlutterLogo(size: context.screenSize.width * 0.3),
                ),
              ),
              const SizedBox(height: 25),
              Visibility(
                maintainSize: true,
                maintainInteractivity: true,
                maintainAnimation: true,
                maintainState: true,
                visible: developerOptionIsEnabled,
                child: ListTile(
                  title: const Text("Choose the mode you want👇"),
                  subtitle: const Text('Enabled'),
                  trailing: CupertinoSwitch(
                    value: developerOptionIsEnabled,
                    onChanged: (off) {
                      if (off) {
                        developerOptionClicks.state = 0;
                      }
                    },
                  ),
                ),
              ),
              Visibility(
                visible: developerOptionIsEnabled,
                child: DropdownButton<String>(
                  items: <String>['dev', 'testing', 'prod'].map((server) {
                    return DropdownMenuItem<String>(
                      value: server,
                      child: Text(server),
                    );
                  }).toList(),
                  isExpanded: true,
                  onChanged: (server) async {
                    if (server != null) serverNotifier.state = server;
                  },
                  value: serverNotifier.state,
                ),
              ),
              Visibility(
                visible:
                    developerOptionIsEnabled && serverNotifier.state == 'dev',
                child: TextField(controller: localUrlController),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Visibility(
                  visible: developerOptionIsEnabled,
                  child: TextButton(
                    onPressed: () {
                      // Update primaryColor, apiUrl, and envName
                      // of config
                    },
                    child: const Text('apply changes'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final developerOptionIsOnProvider = StateProvider<bool>((ref) {
  final developerOptionsClicksCount =
      ref.watch(developerOptionClickCountProvider);
  return developerOptionsClicksCount > 2;
});
final developerOptionClickCountProvider = StateProvider<int>((ref) {
  return 0;
});
