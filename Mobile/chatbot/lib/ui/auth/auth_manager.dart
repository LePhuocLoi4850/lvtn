import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/auth_token.dart';
import '../../models/user.dart';
import '../../services/auth_service.dart';
import 'update.dart';

class AuthManager with ChangeNotifier {
  AuthToken? _authToken;
  Timer? _authTimer;

  final AuthService _authService = AuthService();

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

  Future<void> login(String email, String password, String role) async {
    _setAuthToken(await _authService.login(email, password, role));
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
