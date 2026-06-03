import 'dart:convert';

import 'package:websocket_chat/core/fcm/firebase_access_token_service.dart';
import 'package:http/http.dart' as http;

class PushNotification {
  Future<void> sendNotificationToAnotherUser({
    required String token,
    required String title,
    required String message,
    required String otherUid,
  }) async {
      String  serverAccessToken = await FirebaseAccessTokenService.getServerKey();
      final String apiUrl = "https://fcm.googleapis.com/v1/projects/chatting-notification/messages:send";
      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $serverAccessToken',
          },
          body: jsonEncode({
            "message": {
              "token": token,
              "notification": {
                "title": title,
                "body": message,
              },
              "data": {
                "title": title,
                "body": message,
                "otherUid": otherUid,
              },
              "android": {
                "priority": "high",
              }
            }
          }),
        );
        if (response.statusCode == 200) {
          print("Notification send successfully");
        } else {
          print("Error : Notification failed! ${response.statusCode}");
        }
      } catch (error) {
        print("Exception Error : $error");
      }
  }
}
