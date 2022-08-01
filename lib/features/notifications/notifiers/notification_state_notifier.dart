import 'package:hooks_riverpod/hooks_riverpod.dart'
    show Reader, StateNotifier, StateNotifierProvider;
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../data/models/notification_model.dart';
import '../data/repository/notifications_repo.dart';

class NotificationStateNotifier
    extends StateNotifier<NotificationModelResponse> {
  static final _defaultNotification = NotificationModelResponse(
    notifications: [NotificationModel(id: 'id', title: 'title', body: 'body')],
    totalCount: 1,
  );
  final refreshController = RefreshController(
    initialLoadStatus: LoadStatus.idle,
  );
  NotificationStateNotifier(this._read,
      [NotificationModelResponse? notification])
      : super(notification ?? _defaultNotification);
  final Reader _read;
  late int currentPage = 0;
  late int lastPage = 0;
  void initFCM() async {
    await _read(notificationsRepoProvider).initFCM();
  }

  void notifications() async {
    final repo = _read(notificationsRepoProvider);
    state = await repo.notifications(currentPage);
  }

  void readNotification(String id) async {
    final repo = _read(notificationsRepoProvider);
    state = await repo.readNotification(id);
  }

  void onLoading() async {
    ++currentPage;
    if (currentPage > lastPage) {
      refreshController.loadNoData();
      return;
    }
    final repo = _read(notificationsRepoProvider);
    final result = await repo.notifications(currentPage);
    final moreNotifications = <NotificationModel>[];

    if (result.notifications.isEmpty) {
      refreshController.loadNoData();
      return;
    }

    for (final notification in result.notifications) {
      moreNotifications.add(notification);
    }
    state.copyWith(
      notifications: [...state.notifications, ...moreNotifications],
      totalCount: state.totalCount + moreNotifications.length,
    );
    // lastPage = result.data['last_page'];
    refreshController.loadComplete();
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }
}

final notificationsStateNotifierProvider =
    StateNotifierProvider<NotificationStateNotifier, NotificationModelResponse>(
        (ref) {
  return NotificationStateNotifier(ref.read);
});
