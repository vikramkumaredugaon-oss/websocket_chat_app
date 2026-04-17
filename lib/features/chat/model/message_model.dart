class MessageModel {
  final int id;
  final int senderId;
  final String message;
  final String createdAt;
  final bool seen;
  final bool delivered;
  final String? senderName;
  final bool isLocal;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.message,
    required this.createdAt,
    required this.seen,
    required this.delivered,
    this.senderName,
    this.isLocal = false,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as int,

      // 🔥 SUPPORT BOTH sender_id (REST) & senderId (WS)
      senderId: (json['sender_id'] ?? json['senderId']) as int,

      message: json['message'] ?? '',

      // 🔥 SUPPORT BOTH created_at & createdAt
      createdAt:
      (json['created_at'] ?? json['createdAt']) as String,

      delivered: json['delivered'] == 1 ||
          json['delivered'] == true,

      seen: json['seen'] == 1 || json['seen'] == true,

      isLocal: false,
    );
  }
}