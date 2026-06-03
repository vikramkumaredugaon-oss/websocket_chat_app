import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/app_client.dart';
import '../../../core/storage/local_storage.dart';
import '../../../core/utils/logger.dart';
import '../model/user_model.dart';

class AuthService {
  /// 🔐 Login
  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await ApiClient.post(
        ApiEndpoints.login,
        body: {
          "email": email,
          "password": password,
        },
      );

      // Expected backend response:
      // { token: "...", user: { id, name, email, is_online } }

      final token = res['token'] as String;
      final userJson = res['user'] as Map<String, dynamic>;

      await LocalStorage.saveToken(token);
      await LocalStorage.saveUserId(userJson['id']);

      AppLogger.info("Login success", tag: "AUTH");
      return UserModel.fromJson(userJson);
    } catch (e, s) {
      AppLogger.error(
        "Login failed",
        error: e,
        stackTrace: s,
        tag: "AUTH",
      );
      rethrow;
    }
  }

  /// 📝 Register
  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    String? deviceToken
  }) async {
    try {
      final res = await ApiClient.post(
        ApiEndpoints.register,
        body: {
          "name": name,
          "email": email,
          "password": password,
          "deviceToken":deviceToken
        },
      );

      // Optional: auto-login after register
      final token = res['token'] as String?;
      final userJson = res['user'] as Map<String, dynamic>;

      if (token != null) {
        await LocalStorage.saveToken(token);
        await LocalStorage.saveUserId(userJson['id']);
      }

      AppLogger.info("Register success", tag: "AUTH");
      return UserModel.fromJson(userJson);
    } catch (e, s) {
      AppLogger.error(
        "Register failed",
        error: e,
        stackTrace: s,
        tag: "AUTH",
      );
      rethrow;
    }
  }

  /// 👤 Profile
  static Future<UserModel> getProfile() async {
    try {
      final res = await ApiClient.get(ApiEndpoints.profile);
      return UserModel.fromJson(res);
    } catch (e, s) {
      AppLogger.error(
        "Get communities failed",
        error: e,
        stackTrace: s,
        tag: "AUTH",
      );
      rethrow;
    }
  }

  /// 🚪 Logout
  static Future<void> logout() async {
    await LocalStorage.clear();
    AppLogger.info("User logged out", tag: "AUTH");
  }
}