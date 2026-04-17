class UserListModel {
  final int id;
  final String name;
  final String email;
  final bool isOnline;
  final String? lastSeen;

  UserListModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isOnline,
    this.lastSeen,
  });

  /// 🔁 JSON → Model
  factory UserListModel.fromJson(Map<String, dynamic> json) {
    return UserListModel(
      id: json['id'],
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      isOnline: json['is_online'] == 1 || json['is_online'] == true,
      lastSeen: json['last_seen'],
    );
  }

  /// 🔁 Model → JSON (optional)
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "is_online": isOnline ? 1 : 0,
      "last_seen": lastSeen,
    };
  }
}