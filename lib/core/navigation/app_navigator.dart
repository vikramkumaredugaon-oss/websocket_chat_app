import 'package:flutter/material.dart';

class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  static void openChat(int conversationId) {
    navigatorKey.currentState?.pushNamed(
      "/chat",
      arguments: {
        "conversationId": conversationId,
      },
    );
  }

  static void openUsers() {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      "/users",
          (route) => false,
    );
  }

  static void openLogin() {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      "/login",
          (route) => false,
    );
  }
}