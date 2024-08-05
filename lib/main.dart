import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tata/flavors.dart';
import 'package:tata/src/core/services/push_notifications_service.dart';

import 'firebase_options_dev.dart' as firebase_dev_options;
import 'firebase_options_dev.dart' as firebase_prod_options;
import 'src/app.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  FirebaseOptions options = F.appFlavor == Flavor.dev
      ? firebase_dev_options.DefaultFirebaseOptions.currentPlatform
      : firebase_prod_options.DefaultFirebaseOptions.currentPlatform;

  await Firebase.initializeApp(name: F.appFlavor!.name, options: options);

  // initialize Firebase Messaging
  await PushNotificationsService.init();

  runApp(const ProviderScope(child: App()));
}
