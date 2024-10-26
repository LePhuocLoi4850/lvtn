class UserData {
  final String userId;
  final String email;
  final String level;

  UserData({
    required this.userId,
    required this.email,
    required this.level,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'level': level,
    };
  }

  static UserData fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['userId'],
      email: json['email'],
      level: json['level'],
    );
  }
}
