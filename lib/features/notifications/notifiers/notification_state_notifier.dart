import 'package:hooks_riverpod/hooks_riverpod.dart'
    show Reader, StateNotifier, StateNotifierProvider;
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../data/models/notification_model.dart';
import '../data/repositories/notifications_repo.dart';

class NotificationStateNotifier
    extends StateNotifier<NotificationModelResponse> {
  static final _defaultNotification = NotificationModelResponse(
    notifications: [
      NotificationModel(
        id: '1',
        title: 'Happy coding!!',
        body: 'Are you having fun with code?',
      )
    ],
    totalCount: 1,
  );
  final refreshController = RefreshController(
    initialLoadStatus: LoadStatus.idle,
  );
  // Also make sure if watch is needed or not
  NotificationStateNotifier(this.read)
      : _repo = read(notificationsRepoProvider),
        super(_defaultNotification) {
    initFCM();
  }
  final Reader read;
  final NotificationsRepo _repo;
  late int currentPage = 0;
  late int lastPage = 0;
  void initFCM() async {
    //only un comment this line if you set up firebase vie firebase cli
    // await _repo.initFCM();
  }

  void notifications() async {
    refreshController.resetNoData();
    try {
      state = await _repo.notifications(currentPage);
    } on Exception catch (_) {
      // TODO
      refreshController.refreshFailed();
    }
    refreshController.refreshCompleted();
  }

  void readNotification(String id) async {
    state = await _repo.readNotification(id);
  }

  void onLoading() async {
    ++currentPage;
    if (currentPage > lastPage) {
      refreshController.loadNoData();
      return;
    }
    final result = await _repo.notifications(currentPage);
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
