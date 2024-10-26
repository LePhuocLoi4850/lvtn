import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/http_exception.dart';
import '../models/auth_token.dart';
import '../models/user.dart';

class AuthService {
  static const _authTokenKey = 'authToken';
  late final String? _apiKey;
  late final String? _databaseurl;
  String? _token;
  String? get token => _token;
  UserData? _newUser;

  AuthService() {
    _apiKey = dotenv.env['FIREBASE_API_KEY'];
    _databaseurl = dotenv.env['FIREBASE_RTDB_URL'];
  }

  String _buildAuthUrl(String method) {
    return 'https://identitytoolkit.googleapis.com/v1/accounts:$method?key=$_apiKey';
  }

  Future<AuthToken> _authenticate(
      String email, String password, String role, String method) async {
    try {
      final url = Uri.parse(_buildAuthUrl(method));
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'role': role,
            'returnSecureToken': true,
          },
        ),
      );
      final responseJson = json.decode(response.body);
      if (responseJson['error'] != null) {
        throw HttpException.firebase(responseJson['error']['message']);
      }

      final authToken = _fromJson(responseJson);
      _token = authToken.token;
      await _saveAuthToken(authToken);

      final userData = await _getUserDataFromDatabase(responseJson['localId']);
      print(responseJson);
      List<UserData> userDataList = [];

      if (userData == null) {
        final newUser = UserData(
          userId: responseJson['localId'],
          email: email,
          level: role,
          name: '',
          phone: '',
          ngaysinh: '',
          gioitinh: '',
          diachi: '',
          career: '',
          describe: '',
        );
        _newUser = newUser;
        await _saveUserDataToDatabase(newUser);
      } else {
        _newUser = userData;
      }
      print(userData);

      print(userDataList);

      return authToken;
    } catch (error) {
      rethrow;
    }
  }

  Future<UserData?> _getUserDataFromDatabase(String userId) async {
    final url = Uri.parse('$_databaseurl/users/$userId.json?auth=$token');

    try {
      print(userId);
      final response = await http.get(url);

      if (response.statusCode == 200 && response.body != 'null') {
        print(response.body);
        final userDataJson = json.decode(response.body);
        return UserData.fromJson(userDataJson);
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  Future<UserData?> getUserData(String userId) async {
    try {
      final userData = await _getUserDataFromDatabase(userId);
      return userData;
    } catch (error) {
      print('Error getting user data: $error');
      return null;
    }
  }

  Future<void> updateUserData(UserData userData) async {
    final url =
        Uri.parse('$_databaseurl/users/${userData.userId}.json?auth=$token');

    try {
      final response = await http.patch(
        url,
        body: json.encode(userData.toJson()),
      );

      if (response.statusCode != 200) {
        throw HttpException('Failed to update user data in the database');
      }
    } catch (error) {
      print(error);
      throw HttpException('Failed to update user data in the database');
    }
  }

  Future<void> _saveUserDataToDatabase(UserData userData) async {
    final url =
        Uri.parse('$_databaseurl/users/${userData.userId}.json?auth=$token');

    try {
      final response = await http.put(
        url,
        body: json.encode(userData.toJson()),
      );

      if (response.statusCode != 200) {
        throw HttpException('Failed to save user data to the database');
      }
    } catch (error) {
      print(error);
      throw HttpException('Failed to save user data to the database');
    }
  }

  // String? isauth() {
  //   return _newUser?.level;
  // }
  String isauth() {
    return _newUser != null ? _newUser!.level : "company";
  }

  // Future<AuthToken> signup(
  //     String email, String password, String role, String userId) {
  //   return _authenticate(email, password, role, 'signUp', userId);
  // }

  Future<AuthToken> login(String email, String password, String role) {
    return _authenticate(email, password, role, 'signInWithPassword');
  }

  Future<void> _saveAuthToken(AuthToken authToken) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_authTokenKey, json.encode(authToken.toJson()));
  }

  AuthToken _fromJson(Map<String, dynamic> json) {
    return AuthToken(
      token: json['idToken'],
      userId: json['localId'],
      expiryDate: DateTime.now().add(
        Duration(
          seconds: int.parse(
            json['expiresIn'],
          ),
        ),
      ),
      role: 'roleId',
    );
  }

  Future<AuthToken?> loadSavedAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_authTokenKey)) {
      return null;
    }
    final savedToken = prefs.getString(_authTokenKey);

    final authToken = AuthToken.fromJson(json.decode(savedToken!));
    if (!authToken.isValid) {
      return null;
    }
    return authToken;
  }

  Future<void> clearSavedAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_authTokenKey);
  }

  Future<UserData> signup(
    String email,
    String password,
    String role,
    BuildContext context,
    void Function(UserData) navigateToProfilePage,
  ) async {
    try {
      // Thực hiện đăng ký tài khoản và nhận authentication token
      final authToken = await _authenticate(email, password, role, 'signUp');

      // Kiểm tra xem authentication token có hợp lệ không
      if (authToken != null && authToken.isValid) {
        // Thực hiện lấy thông tin người dùng từ cơ sở dữ liệu
        final userData = await _getUserDataFromDatabase(authToken.userId);

        // Nếu không có thông tin người dùng, tạo mới và lưu vào cơ sở dữ liệu
        if (userData == null) {
          final newUser = UserData(
            userId: authToken.userId,
            email: email,
            level: role, name: '', phone: '', ngaysinh: '', gioitinh: '',
            diachi: '', career: '', describe: '',
            // Các thông tin khác của người dùng có thể được thêm ở đây nếu cần
          );

          // Lưu thông tin người dùng mới vào cơ sở dữ liệu
          await _saveUserDataToDatabase(newUser);

          // Gọi hàm navigateToProfilePage để điều hướng đến trang cập nhật thông tin cá nhân
          navigateToProfilePage(newUser);

          // Trả về thông tin người dùng mới tạo
          return newUser;
        } else {
          // Nếu đã có thông tin người dùng trong cơ sở dữ liệu, gọi hàm navigateToProfilePage và trả về thông tin người dùng đó
          navigateToProfilePage(userData);
          return userData;
        }
      } else {
        // Nếu authentication token không hợp lệ, ném ra một exception
        throw Exception('Invalid authentication token');
      }
    } catch (error) {
      // Xử lý lỗi nếu có
      throw error;
    }
  }

  // Future<void> signup(
  //   String email,
  //   String password,
  //   String role,
  //   BuildContext context,
  //   void Function(UserData) navigateToProfilePage,
  // ) async {
  //   try {
  //     final authToken = await _authenticate(email, password, role, 'signUp');
  //     if (authToken != null) {
  //       final newUser = _newUser!;
  //       navigateToProfilePage(newUser);
  //     }
  //   } catch (error) {
  //     // Xử lý lỗi nếu có
  //   }
  // }
}
