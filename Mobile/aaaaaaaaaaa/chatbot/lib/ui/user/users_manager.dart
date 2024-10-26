import 'package:chatbot/models/user.dart';

import 'package:flutter/foundation.dart';
import '../../models/auth_token.dart';
import '../../services/users_service.dart';

class UsersManager with ChangeNotifier {
  List<UserData> _items = [];

  final UsersService _usersService;

  UsersManager([AuthToken? authToken])
      : _usersService = UsersService(authToken);

  set authToken(AuthToken? authToken) {
    _usersService.authToken = authToken;
  }

  Future<void> fetchUsers() async {
    _items = await _usersService.fetchUsers();
    notifyListeners();
  }

  Future<void> fetchCompany() async {
    _items = await _usersService.fetchCompany();
    notifyListeners();
  }

  Future<void> searchTitle({String? name}) async {
    _items = await _usersService.searchTitle(name);
    notifyListeners();
  }

  Future<void> searchAddress({String? diachi}) async {
    _items = await _usersService.searchAddress(diachi);
    notifyListeners();
  }

  Future<void> searchCareer({String? career}) async {
    _items = await _usersService.searchCareer(career);
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  List<UserData> get item {
    return [..._items];
  }

  UserData? findById(String id) {
    try {
      return _items.firstWhere((item) => item.userId == id);
    } catch (error) {
      return null;
    }
  }

  Future<void> updateUser(UserData user) async {
    final index = _items.indexWhere((item) => item.userId == user.userId);
    if (index >= 0) {
      if (await _usersService.updateUser(user)) {
        _items[index] = user;
        notifyListeners();
      }
    }
  }

  // Future<void> deleteuser(String id) async {
  //   final index = _items.indexWhere((item) => item.id == id);
  //   user? existinguser = _items[index];
  //   _items.removeAt(index);
  //   notifyListeners();
  //   if (!await _usersService.deleteuser(id)) {
  //     _items.insert(index, existinguser);
  //     notifyListeners();
  //   }
  // }
}
