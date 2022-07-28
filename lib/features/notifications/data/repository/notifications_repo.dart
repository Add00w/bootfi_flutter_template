import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:firebase_messaging/firebase_messaging.dart'
    show
        AndroidNotification,
        FirebaseMessaging,
        RemoteMessage,
        RemoteNotification;
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    show
        AndroidFlutterLocalNotificationsPlugin,
        AndroidInitializationSettings,
        AndroidNotificationChannel,
        AndroidNotificationDetails,
        FlutterLocalNotificationsPlugin,
        IOSInitializationSettings,
        IOSNotificationDetails,
        Importance,
        InitializationSettings,
        NotificationDetails;
// import 'package:hooks_riverpod/hooks_riverpod.dart' show Reader;
import 'package:platform_device_id/platform_device_id.dart';

import '../models/notification_model.dart';

class NotificationsService {
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  late AndroidNotificationChannel _androidNotificationChannel;
  late FirebaseMessaging messaging;
  // final Reader _read;

  // NotificationsService(this._read);

  Future<void> initFCM() async {
    //init firebase
    await Firebase.initializeApp(
        //only un comment this line if you set up firebase vie firebase cli
        //options: DefaultFirebaseOptions.currentPlatform,
        );
    messaging = FirebaseMessaging.instance;

    //initialize local notifications package
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Android Notification Channel
    _androidNotificationChannel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    //save this deviceID and firebase token.
    await setDeviceIdAndFcmToken();

    //initialize local notifications package.
    await _initFlutterLocalNotifications();

    //Permissions
    await _setupFcmNotificationSettings();

    //Create the channel on the device (if a channel with an id already exists,
    // it will be updated):
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidNotificationChannel);

    // Get any messages which caused the application to open from
    // a terminated state.
    await messaging.getInitialMessage();

    //foreground messages
    FirebaseMessaging.onMessage.listen(_showMessage);

    //Fires when a new FCM token is generated.
    messaging.onTokenRefresh.listen((event) async {
      debugPrint("token refreshed");
      await setDeviceIdAndFcmToken();
    });

    //background messages
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  }

  ///handle fcm notification settings (sound,badge..etc)
  Future<void> _setupFcmNotificationSettings() async {
    //iOS Configuration
    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,
    );

    //Request permission with defaults
    await messaging.requestPermission();
  }

  static Future<void> _backgroundHandler(RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
    debugPrint("Handling a background message: ${message.messageId}");
  }

  Future<void> _showMessage(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    // AppleNotification? apple = notification?.apple;
    debugPrint('Message data: ${message.data}');

    final androidNotificationDetails = AndroidNotificationDetails(
      _androidNotificationChannel.id,
      _androidNotificationChannel.name,
      channelDescription: _androidNotificationChannel.description,
      icon: android?.smallIcon,
    );
    const iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOSPlatformChannelSpecifics,
    );
    _flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification?.title,
      notification?.body,
      platformChannelSpecifics,
    );
  }

  Future<void> setDeviceIdAndFcmToken() async {
    // final idAndToken = await deviceIdAndToken();
    // final body = {
    //   'device_id': idAndToken[0],
    //   'fmc_token': idAndToken[1],
    // };
    // await app.client.post(
    //   Uri.parse(endpoints.setDeviceIdAndFCMToken),
    //   body: body,
    // );
  }

  Future<List<String>> deviceIdAndToken() async {
    String deviceId = await PlatformDeviceId.getDeviceId ?? '';
    String fcmToken = '';
    fcmToken = await messaging.getToken() ?? '';

    return [deviceId, fcmToken];
  }

  Future<void> _initFlutterLocalNotifications() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<NotificationModelResponse> notifications(int page) async {
    // final configs = await _read(configurationsProvider.future);
    // Get the notifications from the server and convert to NotificationModel
    // final response = await _read(httpProvider).get...
    // final result = NotificationModelResponse(
    //   notifications: response.data['notifications'].map((e) {
    //     return NotificationModel.fromJson(e);
    //   }).toList(growable: false),
    //   totalCount: response.data['total'],
    // );
    // return result;
    return NotificationModelResponse(
      notifications: [
        NotificationModel(id: 'id', title: 'title', body: 'body'),
      ],
      totalCount: 5,
    );
  }

  Future<NotificationModelResponse> readNotification(String id) async {
    // final configs = await _read(configurationsProvider.future);
    //Read a notification and get the notifications
    // from the server and convert to NotificationModel
    // final response = await _read(httpProvider).post...
    // final result = NotificationModelResponse(
    //   notifications: response.data['notifications'].map((e) {
    //     return NotificationModel.fromJson(e);
    //   }).toList(growable: false),
    //   totalCount: response.data['total'],
    // );
    // return result;
    return NotificationModelResponse(
      notifications: [
        NotificationModel(id: 'id', title: 'title', body: 'body'),
      ],
      totalCount: 5,
    );
  }
}
