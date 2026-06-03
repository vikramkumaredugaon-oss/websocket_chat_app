import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void initialize() {
    const InitializationSettings initializationSettings = InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher')
    );
    _localNotificationsPlugin.initialize(settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if(response.payload != null){
          Map<String,dynamic> data = jsonDecode(response.payload!);
        }
      },
    );
  }
  Future<void> requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true
    );
    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print("Permission Granted");
    }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print("User Granted Provisional Permission");
    }else{
      print("User Denied Permission");
    }
  }
  Future<void> initNotification(BuildContext context) async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      sound: true,
      badge: true,
      alert: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handelMessage(context, message.data);
    });
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        handelMessage(context, message.data);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    String title = message.notification?.title ?? message.data['title'] ?? '';
    String body = message.notification?.body ?? message.data['body'] ?? '';

    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _localNotificationsPlugin.show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: title,
      body: body,
      payload: jsonEncode(message.data),
      notificationDetails: notificationDetails,
    );
  }

  Future<void> handelMessage(
      BuildContext context,
      Map<String, dynamic> data,
      ) async {
    if (data.containsKey("otherUid") && data.containsKey("title")) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) =>
      //         ChatScreen(receiverId: data["otherUid"], name: data["title"]),
      //   ),
      // );
    } else {
      print("User Not Found...");
    }
  }
}