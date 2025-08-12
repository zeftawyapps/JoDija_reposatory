import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FCMService {

  Future<void> fcmInit() async {
    try {
      await Firebase.initializeApp();
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      // Request permission for iOS
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        if (kDebugMode) {
          print('User granted permission');
        }
      } else {
        if (kDebugMode) {
          print('User declined or has not accepted permission');
        }
      }

      // Get the token
      String? token = await messaging.getToken();
      if (kDebugMode) {
        print("FCM Token: $token");
      }

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (kDebugMode) {
          print('Received a foreground message: ${message.notification?.title}');
        }
        // Handle the notification in foreground
        _handleForegroundMessage(message);
      });

      // Handle background messages
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

      // Handle notification when app is opened from background
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        if (kDebugMode) {
          print('App opened from notification: ${message.notification?.title}');
        }
        _handleNotificationTap(message);
      });

    } catch (e) {
      if (kDebugMode) {
        print('Error initializing FCM: $e');
      }
    }
  }

  // Handle foreground notification
  void _handleForegroundMessage(RemoteMessage message) {
    // Add your custom logic for handling foreground notifications
    // For example, show a local notification or update UI
  }

  // Handle notification tap
  void _handleNotificationTap(RemoteMessage message) {
    // Add your custom logic for handling notification taps
    // For example, navigate to a specific screen based on notification data
  }
}

// Background message handler must be a top-level function
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print('Handling a background message: ${message.notification?.title}');
  }
  // You can add your custom logic here
}