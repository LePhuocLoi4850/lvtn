// class AuthToken {
//   final String _token;
//   final String _userId;
//   final DateTime _expiryDate;

//   AuthToken({
//     token,
//     userId,
//     expiryDate,
//   })  : _token = token,
//         _userId = userId,
//         _expiryDate = expiryDate;

//   bool get isValid {
//     return token != null;
//   }

//   String? get token {
//     if (_expiryDate.isAfter(DateTime.now())) {
//       return _token;
//     }
//     return null;
//   }

//   String get userId {
//     return _userId;
//   }

//   DateTime get expiryDate {
//     return _expiryDate;
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'authToken': _token,
//       'userId': _userId,
//       'expiryDate': _expiryDate.toIso8601String(),
//     };
//   }

//   static AuthToken fromJson(Map<String, dynamic> json) {
//     return AuthToken(
//       token: json['authToken'],
//       userId: json['userId'],
//       expiryDate: DateTime.parse(json['expiryDate']),
//     );
//   }
// }
class AuthToken {
  final String _token;
  final String _userId;
  final DateTime _expiryDate;
  final String _role;

  AuthToken({
    required String token,
    required String userId,
    required DateTime expiryDate,
    required String role, // Thêm trường dữ liệu role vào constructor
  })  : _token = token,
        _userId = userId,
        _expiryDate = expiryDate,
        _role = role; // Gán giá trị role

  bool get isValid {
    return token != null;
  }

  String? get token {
    if (_expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  DateTime get expiryDate {
    return _expiryDate;
  }

  String get role => _role; // Phương thức getter cho role

  Map<String, dynamic> toJson() {
    return {
      'authToken': _token,
      'userId': _userId,
      'expiryDate': _expiryDate.toIso8601String(),
      'role': _role, // Thêm role vào đối tượng JSON
    };
  }

  static AuthToken fromJson(Map<String, dynamic> json) {
    return AuthToken(
      token: json['authToken'],
      userId: json['userId'],
      expiryDate: DateTime.parse(json['expiryDate']),
      role: json['role'],
    );
  }
}
