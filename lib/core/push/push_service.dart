import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushService {
  static final FlutterLocalNotificationsPlugin _fln =
      FlutterLocalNotificationsPlugin();
  static bool _inited = false;

  static Future<void> init() async {
    if (_inited) return;

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _fln.initialize(settings);
    _inited = true;

    if (kDebugMode) debugPrint('PushService initialized (local notifications)');
  }

  static Future<void> showLocal({
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'bv_channel',
      'BabiVision',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );

    const details = NotificationDetails(android: androidDetails);
    await _fln.show(0, title, body, details);
  }
}
