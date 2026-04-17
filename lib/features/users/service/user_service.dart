import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/app_client.dart';
import '../../../core/utils/logger.dart';
import '../model/user_list_model.dart';

class UsersService {
  /// 👥 Get all users
  static Future<List<UserListModel>> getUsers() async {
    try {
      final res = await ApiClient.get(ApiEndpoints.users);

      // Expected response: List<user>
      return (res as List)
          .map((e) => UserListModel.fromJson(e))
          .toList();
    } catch (e, s) {
      AppLogger.error(
        "Fetch users failed",
        error: e,
        stackTrace: s,
        tag: "USERS",
      );
      rethrow;
    }
  }

  /// 💬 Create / Get one-to-one conversation
  static Future<int> createOneToOneConversation(int userB) async {
    try {
      final res = await ApiClient.post(
        ApiEndpoints.oneToOneConversation,
        body: {
          "userB": userB,
        },
      );

      return res['id'];
    } catch (e, s) {
      AppLogger.error(
        "Create conversation failed",
        error: e,
        stackTrace: s,
        tag: "USERS",
      );
      rethrow;
    }
  }
}