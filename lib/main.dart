import 'package:flutter/material.dart';
import 'package:websocket_chat/core/storage/local_storage.dart';
import 'app.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  runApp(const MyApp());
}