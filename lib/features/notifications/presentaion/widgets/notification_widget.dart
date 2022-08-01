import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/models/notification_model.dart';
import '../../notifiers/notification_state_notifier.dart';

class NotificationWidget extends HookConsumerWidget {
  const NotificationWidget({Key? key, required this.notification})
      : super(key: key);
  final NotificationModel notification;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref
            .watch(notificationsStateNotifierProvider.notifier)
            .readNotification(notification.id);
      },
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xfffff5e5),
                ),
                child: const Icon(
                  Icons.notifications_none_rounded,
                  color: Color(0xffb59327),
                  size: 16,
                ),
              ),
              const SizedBox(width: 9),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Text(
                  notification.body,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: const Color(0xff121313),
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                ),
              ),
            ],
          ),
          const Divider(
            color: Color(0xffababb7),
          ),
          const SizedBox(height: 12.2),
        ],
      ),
    );
  }
}
