import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushService {
  static final _fln = FlutterLocalNotificationsPlugin();
  static bool _inited = false;

  static Future<void> init() async {
    if (_inited) return;
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _fln.initialize(const InitializationSettings(android: android));
    _inited = true;

    // ملاحظة: إذا بدك Firebase Messaging
    // نزّل firebase_messaging وركّب google-services.json/GoogleService-Info.plist
    // وبعدها فعّل initialization بحسب الدوك.
    if (kDebugMode) debugPrint('PushService initialized (local)');
  }

  static Future<void> showLocal({required String title, required String body}) async {
    const androidDetails = AndroidNotificationDetails(
      'bv_channel', 'BabiVision',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    await _fln.show(0, title, body, const NotificationDetails(android: androidDetails));
  }
}
