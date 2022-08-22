import 'dart:convert' show json;

import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider, ProviderRef;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:platform_device_id/platform_device_id.dart';

import '../../../../core/core.dart';
import '../../notifications.dart';

class NotificationsRepo {
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  late AndroidNotificationChannel _androidNotificationChannel;
  late FirebaseMessaging _messaging;
  final ProviderRef<NotificationsRepo> _ref;
  final InterceptedClient http;
  NotificationsRepo(this._ref) : http = _ref.read(httpProvider);

  Future<void> initFCM() async {
    //init firebase
    await Firebase.initializeApp(
        //only un comment this line if you set up firebase vie firebase cli
        //options: DefaultFirebaseOptions.currentPlatform,
        );
    _messaging = FirebaseMessaging.instance;

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
    await _setDeviceIdAndFcmToken();

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
    await _messaging.getInitialMessage();

    //foreground messages
    FirebaseMessaging.onMessage.listen(_showMessage);

    //Fires when a new FCM token is generated.
    _messaging.onTokenRefresh.listen((event) async {
      debugPrint("token refreshed");
      await _setDeviceIdAndFcmToken();
    });

    //background messages
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  }

  ///handle fcm notification settings (sound,badge..etc)
  Future<void> _setupFcmNotificationSettings() async {
    //iOS Configuration
    _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,
    );

    //Request permission with defaults
    await _messaging.requestPermission();
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

  Future<void> _setDeviceIdAndFcmToken() async {
    final idAndToken = await _deviceIdAndToken();
    final body = {
      'device_id': idAndToken[0],
      'fmc_token': idAndToken[1],
    };
    await http.post(
      Uri.parse(setDeviceIdAndFCMTokenEndpoint),
      body: body,
    );
  }

  Future<List<String>> _deviceIdAndToken() async {
    String deviceId = await PlatformDeviceId.getDeviceId ?? '';
    String fcmToken = '';
    fcmToken = await _messaging.getToken() ?? '';

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
    //Listen to url changes and get notifications.
    final apiUrl = await _ref.watch(
      configurationsProvider.future.select(
        (config) async {
          return (await config).apiUrl;
        },
      ),
    );
    final url = '$apiUrl$notificationsEndpoint?page=$page';
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    final result = NotificationModelResponse(
      notifications: data['notifications'].map((e) {
        return NotificationModel.fromJson(e);
      }).toList(growable: false),
      totalCount: data['total'],
    );
    return result;
  }

  Future<NotificationModelResponse> readNotification(String id) async {
    //Listen to url changes and get notifications.
    final apiUrl = await _ref.watch(
      configurationsProvider.future.select(
        (config) async {
          return (await config).apiUrl;
        },
      ),
    );
    final url = '$apiUrl$readNotificationEndpoint$id';
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    final result = NotificationModelResponse(
      notifications: data['notifications'].map((e) {
        return NotificationModel.fromJson(e);
      }).toList(growable: false),
      totalCount: data['total'],
    );
    return result;
  }
}

final notificationsRepoProvider = Provider<NotificationsRepo>((ref) {
  return NotificationsRepo(ref);
});
