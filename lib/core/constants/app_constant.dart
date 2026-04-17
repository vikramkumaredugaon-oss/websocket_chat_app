class AppConstants {
  // 🏷️ App Info
  static const String appName = "ChatApp";
  static const String appVersion = "1.0.0";

  // ⏱️ Network
  static const int apiTimeoutSeconds = 30;
  static const int socketReconnectDelaySeconds = 5;

  // 📄 Pagination / Limits
  static const int messagesPageSize = 20;
  static const int usersPageSize = 50;

  // 📐 UI Spacing / Radius
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double borderRadius = 12.0;

  // 🕒 Date & Time Formats
  static const String chatTimeFormat = "hh:mm a";
  static const String chatDateFormat = "dd MMM yyyy";

  // 🔐 Storage Keys
  static const String keyAuthToken = "auth_token";
  static const String keyUserId = "user_id";
  static const String keyOnboardingSeen = "onboarding_seen"; // ✅ ADD THIS

  // 🧪 Environment Flags
  static const bool isDebug = true; // production me false
}