import 'package:chatbot/models/ring.dart';
import 'package:chatbot/models/user.dart';

import 'package:flutter/foundation.dart';
import '../../models/cart_item.dart';
import '../../models/job.dart';

class NotificationManager with ChangeNotifier {
  Map<String, Ring> _items = {};

  int get jobCount {
    return _items.length;
  }

  List<Ring> get jobs {
    return _items.values.toList();
  }

  Iterable<MapEntry<String, Ring>> get jobEntries {
    return {..._items}.entries;
  }

  // List<Ring> getUserNotifications(UserData currentUser) {
  //   if (currentUser == null || currentUser.userId == null) {
  //     // Nếu currentUser hoặc userId của currentUser là null, không có thông báo nào được trả về
  //     return [];
  //   }

  //   return _items.values
  //       .where((item) => item.user.userId == currentUser.userId)
  //       .toList();
  // }

  void addNotificationItem(Job job, UserData user) {
    final jobId = job.id!;
    if (!_items.containsKey(jobId)) {
      _items.putIfAbsent(
        jobId,
        () => Ring(
            id: 'c${DateTime.now().toIso8601String()}',
            title: job.title,
            diaChi: job.diachi,
            image: job.imageUrl,
            luong: job.luong,
            creatorId: job.creatorId,
            jobId: job.id!,
            user: user,
            status: 'waiting'),
      );
    }

    notifyListeners();
  }

  void addNotificationAcceptItem(CartItem job, UserData user) {
    final jobId = job.id;
    if (!_items.containsKey(jobId)) {
      _items.putIfAbsent(
        jobId,
        () => Ring(
            id: 'c${DateTime.now().toIso8601String()}',
            title: job.title,
            diaChi: job.diaChi,
            image: job.image,
            luong: job.luong,
            creatorId: job.creatorId,
            jobId: job.id,
            user: user,
            status: 'accepted'), // Chấp nhận
      );
    }

    notifyListeners();
  }

  void addNotificationRejectItem(CartItem job, UserData user) {
    final jobId = job.id;
    if (!_items.containsKey(jobId)) {
      _items.putIfAbsent(
        jobId,
        () => Ring(
            id: 'c${DateTime.now().toIso8601String()}',
            title: job.title,
            diaChi: job.diaChi,
            image: job.image,
            luong: job.luong,
            creatorId: job.creatorId,
            jobId: job.id,
            user: user,
            status: 'rejected'), // Từ chối
      );
    }

    notifyListeners();
  }

  void addApplication(Ring cartItem) {
    final applicationId = cartItem.status;
    if (!_items.containsKey(applicationId)) {
      _items.putIfAbsent(applicationId, () => cartItem);
    }
    notifyListeners();
    print(applicationId);
  }

  void acceptApplication(Ring cartItem) {
    cartItem.status = 'accepted';
    notifyListeners();
  }

  void rejectApplication(Ring cartItem) {
    cartItem.status = 'rejected';
    notifyListeners();
  }

  void removeNotificationItem(String jobId) {
    _items.remove(jobId);
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
      cartString += '  Luong: ${cartItem.luong}\n';
      cartString += '  Image: ${cartItem.image}\n';
      cartString += '  User: ${cartItem.user}\n';
      cartString += '  CreatorId: ${cartItem.creatorId}\n';
      cartString += '  Diachi: ${cartItem.diaChi}\n';
      cartString += '  TrangThai: ${cartItem.status}\n';
    });
    cartString += '}';
    return cartString;
  }
}
