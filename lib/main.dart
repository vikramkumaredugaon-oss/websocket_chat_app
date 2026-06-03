import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:websocket_chat/core/storage/local_storage.dart';
import 'package:websocket_chat/firebase_options.dart';
import 'app.dart';
import 'core/services/local_notification_service.dart';
import 'core/services/push_notification_service.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalStorage.init();
  await LocalNotificationService.init();
  await PushNotificationService.init();
  runApp(const MyApp());
}