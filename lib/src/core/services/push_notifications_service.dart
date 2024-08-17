import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tata/main.dart';
import 'package:tata/src/ui/pages/chat-room-info/chat_room_info_view.dart';

class PushNotificationsService {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    // await initBackgroundMessaging();
    await initOnTapMessaging();
  }

  // initialize on foreground messaging
  static Future<void> initForegroundMessaging() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print('A new onMessage event was published!');
      }
    });
  }

  // initialize on background messaging
  static Future<void> initBackgroundMessaging() async {
    FirebaseMessaging.onBackgroundMessage((message) async {
      print('Handling a background message ${message.messageId}');
    });
  }

  // initialize on tap notifications
  static Future<void> initOnTapMessaging() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        navigatorKey.currentState
            ?.pushNamed(ChatRoomInfoView.routeName, arguments: {
          "chatRoomId": message.data['chatRoomId'],
        });
      }
    });
  }

  // initialize the local notifications
  static Future<void> initLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('assets/images/tata_logo.png');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    if (Platform.isAndroid) {
      _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestNotificationsPermission();
    }

    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onReceiveNotifications,
      onDidReceiveBackgroundNotificationResponse: onReceiveNotifications,
    );
  }

  static void onReceiveNotifications(
      NotificationResponse notificationResponse) {}
}
