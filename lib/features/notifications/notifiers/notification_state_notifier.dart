import 'package:bootfi_flutter_template/features/notifications/data/models/notification_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore_for_file: unnecessary_late
late final defaultNotification = NotificationModelResponse(
  notifications: [NotificationModel(id: 'id', title: 'title', body: 'body')],
  totalCount: 5,
);

class NotificationStateNotifier
    extends StateNotifier<NotificationModelResponse> {
  NotificationStateNotifier(NotificationModelResponse? notification)
      : super(notification ?? defaultNotification);
}
