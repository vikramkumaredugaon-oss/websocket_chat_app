import 'package:firebase_messaging/firebase_messaging.dart';
import '../network/app_client.dart';

class UserDeviceTokenService {
  static final FirebaseMessaging _messaging =
      FirebaseMessaging.instance;

  static Future<void> init() async {
    await saveTokenToServer();

    _messaging.onTokenRefresh.listen(
          (token) async {
        print("Refreshed Token => $token");

        await updateTokenOnServer(token);
      },
      onError: (e) {
        print("Token Refresh Error => $e");
      },
    );
  }

  static Future<String?> getDeviceToken() async {
    try {
      String? token = await _messaging.getToken();

      print("Current Device Token => $token");

      return token;
    } catch (e) {
      print("Get Token Error => $e");
      return null;
    }
  }

  static Future<void> saveTokenToServer() async {
    try {
      final token = await getDeviceToken();

      if (token == null) return;

      await ApiClient.post(
        "/users/device-token",
        body: {
          "deviceToken": token,
        },
      );

      print("Token saved to server");
    } catch (e) {
      print("Save Token Error => $e");
    }
  }

  static Future<void> updateTokenOnServer(
      String token) async {
    try {
      await ApiClient.post(
        "/users/device-token",
        body: {
          "deviceToken": token,
        },
      );

      print("Updated token on server");
    } catch (e) {
      print("Update Token Error => $e");
    }
  }
}