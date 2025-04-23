// lib/firebase_notification_service.dart
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Local notifications setup with no icon
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher'); // Default icon if you don't want a custom one
    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Firebase messaging setup
    await messaging.requestPermission();
    String? token = await messaging.getToken();
    print("FCM Token: $token");

    // Background message handler
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

    // Foreground message handler
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message: ${message.notification?.title}');
      showNotification(message);
    });
  }

  static Future<void> backgroundMessageHandler(RemoteMessage message) async {
    print("Handling background message: ${message.notification?.title}");
  }

  static Future<void> showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id', 
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      icon: null,  // No icon, leave it null
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
}





// // lib/firebase_notification_service.dart
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class FirebaseNotificationService {
//   static FirebaseMessaging messaging = FirebaseMessaging.instance;
//   static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   static Future<void> initialize() async {
//     // Local notifications setup
//     const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
//     final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);

//     // Firebase messaging setup
//     await messaging.requestPermission();
//     String? token = await messaging.getToken();
//     print("FCM Token: $token");

//     // Background message handler
//     FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

//     // Foreground message handler
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Foreground message: ${message.notification?.title}');
//       showNotification(message);
//     });
//   }

//   static Future<void> backgroundMessageHandler(RemoteMessage message) async {
//     print("Handling background message: ${message.notification?.title}");
//   }

//   static Future<void> showNotification(RemoteMessage message) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'your_channel_id', 'your_channel_name',
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

//     await flutterLocalNotificationsPlugin.show(
//       0,
//       message.notification?.title,
//       message.notification?.body,
//       platformChannelSpecifics,
//       payload: 'item x',
//     );
//   }
// }
