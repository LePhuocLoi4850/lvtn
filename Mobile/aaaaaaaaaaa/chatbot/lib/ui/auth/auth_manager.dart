import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/auth_token.dart';
import '../../models/user.dart';
import '../../services/auth_service.dart';
import '../user_provider.dart';
import 'update.dart';
import 'update_company.dart';

class AuthManager with ChangeNotifier {
  AuthToken? _authToken;
  Timer? _authTimer;

  final AuthService _authService = AuthService();
  final UserProvider _userProvider = UserProvider();
  String? isAuth() {
    if (authToken != null && authToken!.isValid) {
      return _authService.isauth();
    } else {
      return null;
    }
  }

  AuthToken? get authToken {
    return _authToken;
  }

  void _setAuthToken(AuthToken token) {
    _authToken = token;
    _autoLogout();
    notifyListeners();
  }

  Future<void> signup(
    String email,
    String password,
    String role,
    BuildContext context,
    void Function(UserData) navigateToProfilePage,
  ) async {
    try {
      final newUser = await _authService.signup(
        email,
        password,
        role,
        context,
        navigateToProfilePage,
      );
      _handleSignupSuccess(newUser, context);
    } catch (error) {
      print('Error signing up: $error');
      // Thực hiện các hành động cần thiết khi có lỗi
    }
  }

  void _handleSignupSuccess(UserData newUser, BuildContext context) {
    print('thong tin trước submit');
    print(newUser);
    if (newUser.level == 'company') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UpdateProfileCompanyPage(
            userId: newUser.userId,
            email: newUser.email,
          ),
        ),
      );
    } else if (newUser.level == 'user') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UpdateProfilePage(
            userId: newUser.userId,
            email: newUser.email,
          ),
        ),
      );
    }
    ;
  }

  // Future<void> login(String email, String password, String role) async {
  //   _setAuthToken(await _authService.login(email, password, role));
  // }
  Future<void> login(
      String email, String password, String role, BuildContext context) async {
    try {
      final authToken = await _authService.login(email, password, role);
      final userData = await _authService.getUserData(authToken.userId);

      final userAuthToken = await _authService.getUserAuthToken(userData!);
      _setAuthToken(userAuthToken);
      _userProvider.updateUserData(userData);
      Provider.of<UserProvider>(context, listen: false).setUser(userData);
      print('auth_manager');
      print(userData);
    } catch (error) {
      print('Error logging in: $error');

      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final savedToken = await _authService.loadSavedAuthToken();
    if (savedToken == null) {
      return false;
    }

    _setAuthToken(savedToken);
    return true;
  }

  Future<void> logout() async {
    _authToken = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    await _authService.clearSavedAuthToken();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry =
        _authToken!.expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
