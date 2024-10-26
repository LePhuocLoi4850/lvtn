import 'user.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double luong;
  final String image;
  final UserData user;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.luong,
    required this.image,
    required this.user, // Thêm thông tin người dùng vào CartItem
  });

  CartItem copyWith({
    String? id,
    String? title,
    int? quantity,
    double? luong,
    String? image,
    UserData? user, // Cập nhật thông tin người dùng
  }) {
    return CartItem(
      id: id ?? this.id,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      luong: luong ?? this.luong,
      image: image ?? this.image,
      user: user ?? this.user, // Cập nhật thông tin người dùng
    );
  }

  @override
  String toString() {
    return 'CartItem{id: $id, title: $title, quantity: $quantity, luong: $luong, image: $image, user: $user}';
  }
}
