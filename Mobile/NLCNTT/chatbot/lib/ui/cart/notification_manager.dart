import 'package:chatbot/models/user.dart';

import '../../models/cart_item.dart';
import 'package:flutter/foundation.dart';
import '../../models/job.dart';

class NotificationManager with ChangeNotifier {
  Map<String, CartItem> _items = {};

  int get jobCount {
    return _items.length;
  }

  List<CartItem> get jobs {
    return _items.values.toList();
  }

  Iterable<MapEntry<String, CartItem>> get jobEntries {
    return {..._items}.entries;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.luong * cartItem.quantity;
    });
    return total;
  }

  void addNotificationItem(Job job, UserData user) {
    final jobId = job.id!;
    if (!_items.containsKey(jobId)) {
      _items.putIfAbsent(
        jobId,
        () => CartItem(
            id: 'c${DateTime.now().toIso8601String()}',
            title: job.title,
            quantity: 1,
            image: job.imageUrl,
            luong: job.luong,
            user: user),
      );
    }

    notifyListeners();
  }

  void removeNotificationItem(String jobId) {
    if (_items.containsKey(jobId)) {
      return;
    }
    if (_items[jobId]?.quantity as num > 1) {
      _items.update(
        jobId,
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(jobId);
    }
    notifyListeners();
  }

  void clearNotificationItem(String jobId) {
    _items.remove(jobId);
    notifyListeners();
  }

  void clearAllNotificationItems() {
    _items = {};
    notifyListeners();
  }

  @override
  String toString() {
    var cartString = 'NotificationManager{\n';
    _items.forEach((key, cartItem) {
      cartString += '  Title: ${cartItem.title}\n';
      cartString += '  Quantity: ${cartItem.quantity}\n';
      cartString += '  Luong: ${cartItem.luong}\n';
      cartString += '  Image: ${cartItem.image}\n';
      cartString += '  User: ${cartItem.user}\n';
    });
    cartString += '}';
    return cartString;
  }
}
