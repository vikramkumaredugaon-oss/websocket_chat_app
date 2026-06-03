class UserModel {
  final int id;
  final String name;
  final String email;
  final String? deviceToken;
  final bool isOnline;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.deviceToken,
    required this.isOnline,
  });

  /// 🔁 JSON → Model
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      deviceToken: json['deviceToken'] ?? '',
      isOnline: json['is_online'] == 1 || json['is_online'] == true,
    );
  }

  /// 🔁 Model → JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "deviceToken":deviceToken,
      "is_online": isOnline ? 1 : 0,
    };
  }
}