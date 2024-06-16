import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tata/src/core/services/push_notifications_service.dart';

import 'firebase_options.dart';
import 'src/app.dart';

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    print('Handling a background message ${message.messageId}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // initialize Firebase Messaging
  await PushNotificationsService.init();

  // initialize local notifications
  await PushNotificationsService.initLocalNotifications();

  // Listen to background messages
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Listen to on tap message
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print('A new onMessageOpenedApp event was published!');
    }
  });

  // Listen to foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      print('A new onMessage event was published!');
    }
  });

  // Listen to terminated messages
  final RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    print('A new onLaunch event was published!');
  }

  runApp(const ProviderScope(child: App()));
}
