import 'dart:async';
import 'dart:convert';

import '../../../core/base/base_viewmodel.dart';
import '../../../core/constants/app_constant.dart';
import '../../../core/network/socket_client.dart';
import '../../../core/utils/logger.dart';
import '../model/message_model.dart';
import '../service/chat_service.dart';

class ChatViewModel extends BaseViewModel {
  final int conversationId;
  final int myUserId;
  final int otherUserId;

  ChatViewModel({
    required this.conversationId,
    required this.myUserId,
    required this.otherUserId,
  });

  // 💬 Messages list
  final List<MessageModel> messages = [];

  // 📄 Pagination
  int _page = 1;
  bool _hasMore = true;
  bool _isFetchingMore = false;

  StreamSubscription? _socketSubscription;

  /// 🔥 INIT (called from BaseView)
  Future<void> init() async {
    AppLogger.info("ChatViewModel init", tag: "CHAT_VM");

    await SocketClient.connect(); // 🔥 VERY IMPORTANT
    await _loadInitialMessages();
    _listenSocket();
  }

  /// 📥 Load initial messages
  Future<void> _loadInitialMessages() async {
    try {
      setLoading();

      final data = await ChatService.getMessages(
        conversationId,
        page: _page,
        limit: AppConstants.messagesPageSize,
      );

      messages.addAll(data);
      _hasMore = data.length == AppConstants.messagesPageSize;

      setIdle();
    } catch (e) {
      setError("Failed to load messages");
    }
  }

  /// 📄 Load more (pagination)
  Future<void> loadMore() async {
    if (!_hasMore || _isFetchingMore) return;

    try {
      _isFetchingMore = true;
      _page++;

      final data = await ChatService.getMessages(
        conversationId,
        page: _page,
        limit: AppConstants.messagesPageSize,
      );

      messages.insertAll(0, data);
      _hasMore = data.length == AppConstants.messagesPageSize;
      notifyListeners();
    } catch (e) {
      AppLogger.error("Pagination failed", error: e, tag: "CHAT_VM");
    } finally {
      _isFetchingMore = false;
    }
  }

  /// 📡 Listen WebSocket messages
  void _listenSocket() {
    _socketSubscription = SocketClient.stream.listen((data) {
      try {
        final Map<String, dynamic> payload =
        data is String ? jsonDecode(data) : data;

        final msg = MessageModel.fromJson(payload);

        // ❌ Ignore other conversations
        if (payload['conversationId'] != conversationId &&
            payload['conversation_id'] != conversationId) {
          return;
        }

        // 🔄 Remove optimistic temp message
        messages.removeWhere(
              (m) =>
          m.isLocal &&
              m.senderId == msg.senderId &&
              m.message == msg.message,
        );

        messages.add(msg);
        notifyListeners();

        // 👁️ Seen
        if (msg.senderId != myUserId) {
          _markSeen([msg.id]);
        }
      } catch (e, s) {
        AppLogger.error(
          "Socket parse failed",
          error: e,
          stackTrace: s,
          tag: "CHAT_VM",
        );
      }
    });
  }


  /// 📤 Send message (WebSocket primary)

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    // 1️⃣ Optimistic local message (sender UI)
    final tempMessage = MessageModel(
        id: DateTime.now().millisecondsSinceEpoch * -1, // temp id
        senderId: myUserId,
        message: text.trim(),
        createdAt: DateTime.now().toIso8601String(),
        seen: false,
        delivered: false,
        isLocal: true
    );

    messages.add(tempMessage);
    notifyListeners(); // 👈 UI updates instantly

    // 2️⃣ Send via WebSocket
    final payload = {
      "conversationId": conversationId,
      "senderId": myUserId,
      "receiverIds": [otherUserId],
      "message": text.trim(),
    };

    SocketClient.send(payload);
  }

  /// 👁️ Mark messages seen
  Future<void> _markSeen(List<int> messageIds) async {
    try {
      await ChatService.markSeen(
        conversationId: conversationId,
        messageIds: messageIds,
      );
    } catch (_) {}
  }

  /// ❌ Dispose
  @override
  void dispose() {
    _socketSubscription?.cancel();
    super.dispose();
  }
}