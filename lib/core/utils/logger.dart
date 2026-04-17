import 'dart:developer';
import '../constants/app_constant.dart';

class AppLogger {
  // 🐞 Debug logs (only in debug mode)
  static void debug(String message, {String tag = "DEBUG"}) {
    if (AppConstants.isDebug) {
      log("🐞 [$tag] $message");
    }
  }

  // ℹ️ Info logs
  static void info(String message, {String tag = "INFO"}) {
    log("ℹ️ [$tag] $message");
  }

  // ⚠️ Warning logs
  static void warning(String message, {String tag = "WARNING"}) {
    log("⚠️ [$tag] $message");
  }

  // ❌ Error logs (with optional error & stacktrace)
  static void error(
      String message, {
        Object? error,
        StackTrace? stackTrace,
        String tag = "ERROR",
      }) {
    log(
      "❌ [$tag] $message",
      error: error,
      stackTrace: stackTrace,
    );
  }
}