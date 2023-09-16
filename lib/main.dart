import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest_10y.dart';

import 'core/app.dart';

// making notification variable as global
FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // intializing notification for schedule routine
  initializeTimeZones();

  // for android
  AndroidInitializationSettings androidInitializationSettings =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  // for ios
  DarwinInitializationSettings iosInitializationSettings =
      const DarwinInitializationSettings();

  // combining both android and ios
  InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
    iOS: iosInitializationSettings,
  );
  runApp(const ProviderScope(child: App()));
}
