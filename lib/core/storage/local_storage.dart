import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constant.dart';

class LocalStorage {
  static SharedPreferences? _prefs;

  /// Call once in main()
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // 🔐 Save token
  static Future<void> saveToken(String token) async {
    await _prefs?.setString(
      AppConstants.keyAuthToken,
      token,
    );
  }

  // 🔐 Get token
  static String? getTokenSync() {
    return _prefs?.getString(AppConstants.keyAuthToken);
  }

  // 👤 Save user id
  static Future<void> saveUserId(int userId) async {
    await _prefs?.setInt(
      AppConstants.keyUserId,
      userId,
    );
  }

  // 👤 Get user id (SYNC – SAFE)
  static int getUserIdSync() {
    return _prefs?.getInt(AppConstants.keyUserId) ?? 0;
  }

  // 👤 Get user id (ASYNC – OPTIONAL)
  static Future<int?> getUserId() async {
    return _prefs?.getInt(AppConstants.keyUserId);
  }

// ✅ Save onboarding status
  static Future<void> setOnboardingSeen(bool value) async {
    await _prefs?.setBool(AppConstants.keyOnboardingSeen, value);
  }

// ✅ Get onboarding status
  static bool getOnboardingSeenSync() {
    return _prefs?.getBool(AppConstants.keyOnboardingSeen) ?? false;
  }

  // ❌ Clear all (logout)
  static Future<void> clear() async {
    await _prefs?.clear();
  }

  // ✅ Check login status
  static bool isLoggedInSync() {
    final token = getTokenSync();
    return token != null && token.isNotEmpty;
  }
}