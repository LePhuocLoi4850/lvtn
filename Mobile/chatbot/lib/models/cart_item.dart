class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double luong;
  final String image;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.luong,
    required this.image,
  });
  CartItem copyWith({
    String? id,
    String? title,
    int? quantity,
    double? luong,
    String? image,
  }) {
    return CartItem(
      id: id ?? this.id,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      luong: luong ?? this.luong,
      image: image ?? this.image,
    );
  }
}
