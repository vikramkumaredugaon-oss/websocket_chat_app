import '../../../core/base/base_viewmodel.dart';
import '../../../core/services/local_notification_service.dart';
import '../../../core/services/push_notification_service.dart';
import '../../../core/storage/local_storage.dart';
import '../../../core/utils/logger.dart';

class SplashViewModel extends BaseViewModel {
  /// App start logic
  Future<String> init() async {

    try {
      setLoading();
      AppLogger.info("Splash init started", tag: "SPLASH");
      // await LocalNotificationService.init();
      // await PushNotificationService.init();
      // await PushNotificationService.handleTerminated();
      final isLoggedIn = await LocalStorage.isLoggedInSync();

      await Future.delayed(const Duration(seconds: 2)); // splash delay

      setIdle();

      if (isLoggedIn) {
        AppLogger.info("User already logged in", tag: "SPLASH");
        return "/users"; // go to users list / update
      } else {
        AppLogger.info("User not logged in", tag: "SPLASH");
        return "/login"; // go to login
      }
    } catch (e, s) {
      AppLogger.error(
        "Splash init failed",
        error: e,
        stackTrace: s,
        tag: "SPLASH",
      );
      setIdle();
      return "/login";
    }
  }
}