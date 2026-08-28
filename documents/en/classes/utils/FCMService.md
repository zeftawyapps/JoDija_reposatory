# FCMService (Firebase Cloud Messaging)

`FCMService` provides utility methods to integrate push notifications via Firebase Cloud Messaging (FCM) into mobile and web Flutter applications.

---

## Features

- Requesting user notification permissions.
- Retrieving and caching FCM registration tokens.
- Listening for foreground and background message streams.
- Subscribing/unsubscribing to FCM topics.

---

## Static & Instance Methods

```dart
class FCMService {
  /// Initializes notification channels and listeners
  Future<void> init();

  /// Gets device FCM registration token
  Future<String?> getToken();

  /// Subscribes the device to a notification topic
  Future<void> subscribeToTopic(String topic);

  /// Unsubscribes from a topic
  Future<void> unsubscribeFromTopic(String topic);
}
```

---

## Usage Example

```dart
import 'package:JoDija_reposatory/utilis/firebase/FCM.dart';

void setupNotifications() async {
  final fcm = FCMService();
  await fcm.init();

  String? token = await fcm.getToken();
  print('FCM Token: $token');

  // Subscribe to general announcements topic
  await fcm.subscribeToTopic('all_users');
}
```

---

## Related Classes

- [`DataSourceConfigration`](../configration.md): Initializes Firebase credentials before FCM setup.
