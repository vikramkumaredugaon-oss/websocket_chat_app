import 'package:flutter/material.dart';
import 'package:websocket_chat/features/auth/view/login_view.dart';
import 'package:websocket_chat/features/auth/view/register_view.dart';
import 'package:websocket_chat/features/dashboard/view/dashboard_view.dart';
import 'package:websocket_chat/features/splash/view/splash_screen.dart';

import '../features/chat/view/chat_screen.dart';
import '../features/users/view/users_view.dart';
import '../core/storage/local_storage.dart';

class AppRoutes {
  static const splash = "/";
  static const login = "/login";
  static const users = "/users";
  static const register = "/register";
  static const chat = "/chat";
  static const bottomNavigation = "/bottomNavigation";

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
        );

      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginView(),
        );

      case users:
        return MaterialPageRoute(
          builder: (_) => const UsersView(),
        );

        case bottomNavigation:
        return MaterialPageRoute(
          builder: (_) => const DashboardView(),
        );

      case register:
        return MaterialPageRoute(
          builder: (_) => const RegisterView(),
        );

      case chat:
        final args =
        settings.arguments as Map<String, dynamic>?;

        // 🛡️ FULL SAFETY CHECK
        if (args == null ||
            args['conversationId'] == null ||
            args['otherUserId'] == null) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(
                child: Text("Invalid chat arguments"),
              ),
            ),
          );
        }

        final int conversationId =
        args['conversationId'] as int;
        final int otherUserId =
        args['otherUserId'] as int;

        final String otherUserName =
            args['otherUserName'] ?? "User";

        final bool isOnline = args['isOnline'] ?? false;
        final String? lastSeen = args['lastSeen'];

        return MaterialPageRoute(
          builder: (_) => ChatView(
            conversationId: conversationId,
            myUserId: LocalStorage.getUserIdSync(),
            otherUserId: otherUserId,
            otherUserName: otherUserName,
            isOnline: isOnline,
            lastSeen: lastSeen,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Route not found")),
          ),
        );
    }
  }
}