import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/app_client.dart';
import '../../../core/utils/logger.dart';
import '../model/message_model.dart';

class ChatService {
  /// 📨 Get messages by conversation (pagination optional)
  ///
  static Future<List<MessageModel>> getMessages(
      int conversationId, {
        int page = 1,
        int limit = 20,
      }) async {
    try {
      final res = await ApiClient.get(
        '${ApiEndpoints.messagesByConversation(conversationId)}?page=$page&limit=$limit',
      );

      // Expected: List<message>
      return (res as List)
          .map((e) => MessageModel.fromJson(e))
          .toList();
    } catch (e, s) {
      AppLogger.error(
        "Fetch messages failed",
        error: e,
        stackTrace: s,
        tag: "CHAT",
      );
      rethrow;
    }
  }


  /// 👁️ Mark messages as seen
  static Future<void> markSeen({
    required int conversationId,
    required List<int> messageIds,
  }) async {
    try {
      await ApiClient.post(
        ApiEndpoints.messageSeen,
        body: {
          "conversationId": conversationId,
          "messageIds": messageIds,
        },
      );
      AppLogger.info("Messages marked as seen", tag: "CHAT");
    } catch (e, s) {
      AppLogger.error(
        "Mark seen failed",
        error: e,
        stackTrace: s,
        tag: "CHAT",
      );
      rethrow;
    }
  }

  /// 📤 Send message via REST (fallback / delivery guarantee)
  /// 👉 Real-time send should be done via SocketClient
  static Future<MessageModel> sendMessageRest({
    required int conversationId,
    required String message,
    required int senderId,
    required List<int> receiverIds,
  }) async {
    try {
      final res = await ApiClient.post(
        ApiEndpoints.messages,
        body: {
          "conversationId": conversationId,
          "message": message,
          "senderId": senderId,
          "receiverIds": receiverIds,
        },
      );

      return MessageModel.fromJson(res);
    } catch (e, s) {
      AppLogger.error(
        "Send message (REST) failed",
        error: e,
        stackTrace: s,
        tag: "CHAT",
      );
      rethrow;
    }
  }
}