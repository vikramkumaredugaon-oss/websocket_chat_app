import 'package:flutter/material.dart';
import 'core/constants/app_constant.dart';
import 'core/navigation/app_navigator.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppNavigator.navigatorKey,
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,

      // 🎨 Global theme
      theme: AppTheme.lightTheme,

      // 🚦 Initial route
      initialRoute: AppRoutes.splash,

      // 🧭 App routing
      onGenerateRoute: AppRoutes.generateRoute,

      // 🌍 Fallback (safety)
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(child: Text("Page not found")),
        ),
      ),
    );
  }
}