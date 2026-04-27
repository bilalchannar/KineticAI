import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationService {
  final _notifications = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(android: android, iOS: ios);
    await _notifications.initialize(settings: initializationSettings);
  }

  Future<void> showNotification({required String title, required String body}) async {
    const android = AndroidNotificationDetails(
      'kinetic_channel',
      'Kinetic AI Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const ios = DarwinNotificationDetails();
    const details = NotificationDetails(android: android, iOS: ios);
    await _notifications.show(
      id: 0,
      title: title,
      body: body,
      notificationDetails: details,
    );
  }
}

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});