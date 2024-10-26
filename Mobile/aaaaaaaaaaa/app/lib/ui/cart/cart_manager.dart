import '../../models/cart_item.dart';
import 'package:flutter/foundation.dart';
import '../../models/job.dart';

class CartManager with ChangeNotifier {
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

  void addItem(Job job) {
    if (_items.containsKey(job.id)) {
      _items.update(
        job.id!,
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        job.id!,
        () => CartItem(
          id: 'c${DateTime.now().toIso8601String()}',
          title: job.title,
          quantity: 1,
          image: job.imageUrl,
          luong: job.luong,
        ),
      );
    }

    notifyListeners();
  }

  void removeItem(String jobId) {
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

  void clearItem(String jobId) {
    _items.remove(jobId);
    notifyListeners();
  }

  void clearAllItems() {
    _items = {};
    notifyListeners();
  }
}
