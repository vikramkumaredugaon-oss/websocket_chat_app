class ApiEndpoints {
  // 🌐 Base URLs
  static const String baseUrl = "https://chat.edugaondev.com";
  static const String socketUrl = "wss://chat.edugaondev.com";

  // 🔐 Auth
  static const String login = "/auth/login";
  static const String register = "/auth/register";
  static const String profile = "/users/communities";

  // 👤 Users
  static const String users = "/users";

  // 💬 Conversations
  static const String oneToOneConversation = "/conversations/one-to-one";
  static const String conversations = "/conversations";

  // 📨 Messages
  static const String messages = "/messages"; // GET /messages/{conversationId}
  static const String messageSeen = "/messages/seen";

  // 🔌 WebSocket (helper)
  static String socketConnect(String token) {
    return "$socketUrl?token=$token";
  }

  // 🔧 Helper for dynamic endpoints
  static String messagesByConversation(int conversationId) {
    return "$messages/$conversationId";
  }
}