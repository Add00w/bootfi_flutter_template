import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/models/notification_model.dart';

class NotificationStateNotifier
    extends StateNotifier<NotificationModelResponse> {
  static final defaultNotification = NotificationModelResponse(
    notifications: [NotificationModel(id: 'id', title: 'title', body: 'body')],
    totalCount: 5,
  );

  NotificationStateNotifier(NotificationModelResponse? notification)
      : super(notification ?? defaultNotification);
}
