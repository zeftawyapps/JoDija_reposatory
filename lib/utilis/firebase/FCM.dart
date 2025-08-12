import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// A service class for handling Firebase Cloud Messaging (FCM) operations.
///
/// This class provides functionality for:
/// - Initializing Firebase and FCM
/// - Requesting notification permissions (iOS)
/// - Handling foreground, background, and notification tap events
/// - Managing FCM tokens
///
/// Example usage:
/// ```dart
/// final fcmService = FCMService();
/// await fcmService.fcmInit();
/// ```
class FCMService {

  /// Initializes Firebase Cloud Messaging and sets up notification handlers.
  ///
  /// This method performs the following operations:
  /// 1. Initializes Firebase app
  /// 2. Requests notification permissions (primarily for iOS)
  /// 3. Retrieves and logs the FCM token
  /// 4. Sets up handlers for foreground, background, and notification tap events
  ///
  /// Throws:
  /// - [FirebaseException] if Firebase initialization fails
  /// - [Exception] for any other initialization errors
  ///
  /// Example:
  /// ```dart
  /// try {
  ///   await fcmService.fcmInit();
  ///   print('FCM initialized successfully');
  /// } catch (e) {
  ///   print('FCM initialization failed: $e');
  /// }
  /// ```
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

  /// Handles notifications received while the app is in the foreground.
  ///
  /// This method is called when a push notification is received while the app
  /// is active and visible to the user. Override this method to implement
  /// custom foreground notification handling logic.
  ///
  /// [message] - The received remote message containing notification data
  ///
  /// Common use cases:
  /// - Display in-app notifications
  /// - Update UI with new data
  /// - Show custom alert dialogs
  ///
  /// Example:
  /// ```dart
  /// void _handleForegroundMessage(RemoteMessage message) {
  ///   showDialog(
  ///     context: context,
  ///     builder: (context) => AlertDialog(
  ///       title: Text(message.notification?.title ?? 'Notification'),
  ///       content: Text(message.notification?.body ?? ''),
  ///     ),
  ///   );
  /// }
  /// ```
  void _handleForegroundMessage(RemoteMessage message) {
    // Add your custom logic for handling foreground notifications
    // For example, show a local notification or update UI
  }

  /// Handles user interaction when a notification is tapped.
  ///
  /// This method is called when the user taps on a notification while the app
  /// is in the background or terminated, causing the app to open or come to
  /// the foreground.
  ///
  /// [message] - The remote message from the tapped notification
  ///
  /// Common use cases:
  /// - Navigate to specific screens based on notification data
  /// - Process deep links from notifications
  /// - Update app state based on notification payload
  ///
  /// Example:
  /// ```dart
  /// void _handleNotificationTap(RemoteMessage message) {
  ///   final String? route = message.data['route'];
  ///   if (route != null) {
  ///     Navigator.pushNamed(context, route);
  ///   }
  /// }
  /// ```
  void _handleNotificationTap(RemoteMessage message) {
    // Add your custom logic for handling notification taps
    // For example, navigate to a specific screen based on notification data
  }
}

/// Background message handler for Firebase Cloud Messaging.
///
/// This function handles push notifications when the app is in the background
/// or terminated. It must be a top-level function (not a class method) as
/// required by Firebase Messaging.
///
/// [message] - The remote message received in the background
///
/// Important notes:
/// - This function runs in a separate isolate
/// - Heavy processing should be avoided to prevent termination
/// - Must call Firebase.initializeApp() before accessing Firebase services
/// - Cannot directly update UI from this handler
///
/// Common use cases:
/// - Log notification events
/// - Cache notification data locally
/// - Update local database
/// - Schedule local notifications
///
/// Example:
/// ```dart
/// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
///   await Firebase.initializeApp();
///   
///   // Cache the notification data
///   final prefs = await SharedPreferences.getInstance();
///   await prefs.setString('last_notification', message.notification?.body ?? '');
///   
///   print('Background message processed: ${message.notification?.title}');
/// }
/// ```
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print('Handling a background message: ${message.notification?.title}');
  }
  // You can add your custom logic here
}