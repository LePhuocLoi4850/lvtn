import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class UserProvider extends ChangeNotifier {
  UserData? _user;
  List<UserData> _items = [];

  UserData? get user => _user;

  void setUser(UserData userData) {
    _user = userData;
    print('truoc');
    print(_user);
    _items.add(userData);
    print('sau');

    print(_items);
    notifyListeners();
  }

  Future<void> updateUserData(UserData userData) async {
    AuthService authService = AuthService();
    try {
      await authService.updateUserData(userData);

      _user = userData;

      notifyListeners();
    } catch (error) {
      // Xử lý lỗi nếu có
      print('Error updating user data: $error');
      throw error;
    }
  }
}
