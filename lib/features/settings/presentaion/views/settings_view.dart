import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/core.dart';
import '../../../auth/auth.dart';
import '../../../notifications/notifications.dart';
import '../../settings.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authProvider);
    final currentLocale = ref.watch(currentLocaleProvider);
    final notifications = ref.watch(notificationsStateNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.locale.settings,
          style: context.textTheme.headline6,
        ),
        backgroundColor: context.theme.bottomAppBarColor,
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.grey.shade50,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 4),
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 0.0,
                margin: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SettingsItem(
                      key: const Key('Language'),
                      title: context.locale.language,
                      trailing:
                          codeToLanguage(currentLocale?.languageCode ?? ''),
                      onTap: () {
                        showModalBottomSheet<dynamic>(
                          context: context,
                          barrierColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return const LanguageModalBottomSheet();
                          },
                        );
                      },
                    ),
                    if (auth)
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SettingsItem(
                            key: const Key('notifications'),
                            title: context.locale.notifications,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const NotificationsView(
                                      key: Key('notificationsPage'),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          Positioned(
                            left: context.locale.localeName == 'en'
                                ? context.screenSize.width * 0.3
                                : null,
                            right: context.locale.localeName == 'ar'
                                ? context.screenSize.width * 0.2
                                : null,
                            child: FutureBuilder<Configuration>(
                                future:
                                    ref.watch(configurationsProvider.future),
                                builder: (context, configs) {
                                  return Container(
                                    width: 28,
                                    height: 17,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8.5),
                                      ),
                                      color: Color(
                                          configs.data!.primaryColor.toInt),
                                    ),
                                    alignment: Alignment.center,
                                    margin: context.locale.localeName == 'en'
                                        ? const EdgeInsets.only(bottom: 5.0)
                                        : null,
                                    child: Text(
                                      '${notifications.totalCount}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                            color: const Color(0xffffffff),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.0,
                                          ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    SettingsItem(
                      key: const Key('aboutUs'),
                      title: context.locale.aboutUs,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const AboutUsView(
                                  key: Key('android_about'));
                            },
                          ),
                        );
                      },
                    ),
                    SettingsItem(
                      key: const Key('contactUs'),
                      title: context.locale.contactUs,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const ContactUsView();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.904,
              height: 53,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xfff1f1f1),
                    elevation: 0.0,
                    shape: const ContinuousRectangleBorder()),
                onPressed: () {
                  if (auth) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginView(),
                      ),
                    );
                  } else {
                    //logout
                  }
                },
                child:
                    // isLoading
                    //     ? const Center(
                    //         child: CircularProgressIndicator(),
                    //       )
                    //     :
                    Text(
                  auth ? context.locale.signOut : context.locale.signIn,
                  style: Theme.of(context).textTheme.button!.copyWith(
                        color: Color(auth ? 0xfff23d3d : 0xff3d9ef2),
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 22),
              child: Text(
                "${context.locale.version} $appVersion",
                key: const Key('Version'),
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: const Color(0xff484848),
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
