import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import './about_us_view.dart';
import './contact_us_view.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../auth/presentation/views/login_view.dart';
import '../../../auth/providers.dart';
import '../../../notifications/notifiers/notification_state_notifier.dart';
import '../../../notifications/presentaion/views/notifications_view.dart';
import '../widgets/language_modal.dart';
import '../widgets/settings_item.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authProvider);
    final notifications = ref.watch(notificationsStateNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
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
                      title: 'Language',
                      trailing: 'English',
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
                            title: 'Notifications',
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
                      title: 'About Us',
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
                      title: 'Contact Us',
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
                  auth ? 'Sign out' : 'Sign in',
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
                "Version $appVersion",
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
