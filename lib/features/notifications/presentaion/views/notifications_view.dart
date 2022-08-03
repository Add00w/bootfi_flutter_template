import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/pull_to_refresh_widget.dart';
import '../../notifiers/notification_state_notifier.dart';
import '../widgets/empty_notification_widget.dart';
import '../widgets/notification_widget.dart';

class NotificationsView extends ConsumerWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(notificationsStateNotifierProvider.notifier);
    final state = ref.watch(notificationsStateNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: context.textTheme.headline6,
        ),
        backgroundColor: context.theme.scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: RefreshableGridList(
        loadingText: '...',
        onRefresh: provider.notifications,
        refreshController: provider.refreshController,
        onLoading: provider.onLoading,
        child: state.notifications.isEmpty
            ? const EmptyNotifications()
            : ListView.builder(
                padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
                itemCount: state.notifications.length + 1,
                itemBuilder: (context, index) => NotificationWidget(
                  notification: state.notifications.first,
                ),
              ),
      ),
    );
  }
}
