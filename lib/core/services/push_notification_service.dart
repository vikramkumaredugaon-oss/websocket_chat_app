import 'package:firebase_messaging/firebase_messaging.dart';
import '../navigation/app_navigator.dart';
import '../network/app_client.dart';
import 'local_notification_service.dart';

class PushNotificationService {
  static final _fcm = FirebaseMessaging.instance;

  /// 🔥 INIT
  static Future<void> init() async {
    await _fcm.requestPermission();

    // 🔑 Get token
    final token = await _fcm.getToken();
    if (token != null) {
      await ApiClient.post(
        "/users/device-token",
        body: {"deviceToken": token},
      );
    }

    // 🟢 FOREGROUND
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification != null) {
        LocalNotificationService.show(
          title: notification.title ?? "New Message",
          body: notification.body ?? "",
        );
      }
    });

    // 🟡 BACKGROUND TAP
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleNavigation(message.data);
    });
  }

  /// 🔴 TERMINATED TAP
  static Future<void> handleTerminated() async {
    final message =
    await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      _handleNavigation(message.data);
    }
  }

  static void _handleNavigation(Map<String, dynamic> data) {
    final conversationId =
    int.tryParse(data['conversationId'].toString());

    if (conversationId != null) {
      AppNavigator.openChat(conversationId);
    }}
}