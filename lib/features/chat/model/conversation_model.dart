class ConversationModel {
  final int id;
  final String type; // one_to_one | group
  final String title; // user name / group name
  final String? lastMessage;
  final String? lastMessageTime;
  final int unreadCount;
  final bool isOnline; // for one-to-one
  final List<int> participantIds;

  ConversationModel({
    required this.id,
    required this.type,
    required this.title,
    this.lastMessage,
    this.lastMessageTime,
    required this.unreadCount,
    required this.isOnline,
    required this.participantIds,
  });

  /// 🔁 JSON → Model
  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'],
      type: json['type'] ?? 'one_to_one',
      title: json['title'] ?? '',
      lastMessage: json['last_message'],
      lastMessageTime: json['last_message_time'],
      unreadCount: json['unread_count'] ?? 0,
      isOnline: json['is_online'] == 1 || json['is_online'] == true,
      participantIds: json['participants'] != null
          ? List<int>.from(json['participants'])
          : [],
    );
  }

  /// 🔁 Model → JSON (optional)
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "type": type,
      "title": title,
      "last_message": lastMessage,
      "last_message_time": lastMessageTime,
      "unread_count": unreadCount,
      "is_online": isOnline ? 1 : 0,
      "participants": participantIds,
    };
  }

  /// 🧩 CopyWith (for unread count update etc.)
  ConversationModel copyWith({
    String? lastMessage,
    String? lastMessageTime,
    int? unreadCount,
    bool? isOnline,
  }) {
    return ConversationModel(
      id: id,
      type: type,
      title: title,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
      isOnline: isOnline ?? this.isOnline,
      participantIds: participantIds,
    );
  }
}