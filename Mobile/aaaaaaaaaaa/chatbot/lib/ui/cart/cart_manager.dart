import 'package:chatbot/models/user.dart';

import '../../models/cart_item.dart';
import 'package:flutter/foundation.dart';
import '../../models/job.dart';

class CartManager with ChangeNotifier {
  Map<String, CartItem> _items = {};
  final List<Job> _savedJobs = [];
  int get jobCount {
    return _items.length;
  }

  List<CartItem> get jobs {
    return _items.values.toList();
  }

  Iterable<MapEntry<String, CartItem>> get jobEntries {
    return {..._items}.entries;
  }

  void addItem(Job job, UserData user) {
    final jobId = job.id!;
    if (!_items.containsKey(jobId)) {
      _items.putIfAbsent(
        jobId,
        () => CartItem(
            id: 'c${DateTime.now().toIso8601String()}',
            title: job.title,
            image: job.imageUrl,
            luong: job.luong,
            diaChi: job.diachi,
            creatorId: job.creatorId,
            jobId: job.id!,
            user: user,
            status: 'waiting'),
      );
      notifyListeners();
    }
  }

  List<Job> getSavedJobs() {
    return _savedJobs;
  }

  Future<void> fetchUser() async {
    _items.forEach((key, cartItem) {
      print('Title: ${cartItem.title}');
      print('Luong: ${cartItem.luong}');
      print('Image: ${cartItem.image}');
      print('User: ${cartItem.user}');
      print('Diachi: ${cartItem.diaChi}');
      print('---------------------------');
    });
  }

  void clearItem(String jobId) {
    _items.remove(jobId);
    notifyListeners();
  }

  void clearAllItems() {
    _items = {};
    notifyListeners();
  }

  @override
  String toString() {
    var cartString = 'CartManager{\n';
    _items.forEach((key, cartItem) {
      cartString += '  Title: ${cartItem.title}\n';
      cartString += '  Luong: ${cartItem.luong}\n';
      cartString += '  Image: ${cartItem.image}\n';
      cartString += '  User: ${cartItem.user}\n';
      cartString += '  CreatorId: ${cartItem.creatorId}\n';
      cartString += '  Diachi: ${cartItem.diaChi}\n';
    });
    cartString += '}';
    return cartString;
  }

  void acceptApplication(CartItem cartItem) {
    cartItem.status = 'accepted';
    notifyListeners();
  }

  void rejectApplication(CartItem cartItem) {
    cartItem.status = 'rejected';
    notifyListeners();
  }
}
