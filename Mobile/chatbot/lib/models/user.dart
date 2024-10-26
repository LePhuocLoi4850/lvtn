class UserData {
  final String userId;
  final String email;
  final String level;
  final String name;
  final String phone;
  final String ngaysinh;
  final String gioitinh;
  final String diachi;
  final String career;
  final String describe;

  UserData({
    required this.userId,
    required this.email,
    required this.level,
    required this.name,
    required this.phone,
    required this.ngaysinh,
    required this.gioitinh,
    required this.diachi,
    required this.career,
    required this.describe,
  });

  UserData copyWith({
    String? userId,
    String? email,
    String? level,
    String? name,
    String? phone,
    String? ngaysinh,
    String? gioitinh,
    String? diachi,
    String? career,
    String? describe,
  }) {
    return UserData(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      level: level ?? this.level,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      ngaysinh: ngaysinh ?? this.ngaysinh,
      gioitinh: gioitinh ?? this.gioitinh,
      diachi: diachi ?? this.diachi,
      career: career ?? this.career,
      describe: describe ?? this.describe,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'level': level,
      'name': name,
      'phone': phone,
      'ngaysinh': ngaysinh,
      'gioitinh': gioitinh,
      'diachi': diachi,
      'career': career,
      'describe': describe,
    };
  }

  static UserData fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['userId'] ?? '',
      email: json['email'] ?? '',
      level: json['level'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      ngaysinh: json['ngaysinh'] ?? '',
      gioitinh: json['gioitinh'] ?? '',
      diachi: json['diachi'] ?? '',
      career: json['career'] ?? '',
      describe: json['describe'] ?? '', // Thêm biến describe vào đây
    );
  }
}
