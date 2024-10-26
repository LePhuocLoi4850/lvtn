import 'user.dart';

class CartItem {
  final String id;
  final String title;
  final double luong;
  final String image;
  final String diaChi;
  final UserData user;
  final String creatorId;
  final String jobId;
  String status;

  CartItem(
      {required this.id,
      required this.title,
      required this.luong,
      required this.image,
      required this.diaChi, // Thêm thông tin địa chỉ vào CartItem
      required this.user,
      required this.creatorId,
      required this.jobId,
      required this.status // Thêm trường creatorId
      });

  CartItem copyWith({
    String? id,
    String? title,
    double? luong,
    String? image,
    String? diaChi, // Cập nhật thông tin địa chỉ
    UserData? user,
    String? creatorId,
    String? jobId,
    String? status, // Thêm trường creatorId
  }) {
    return CartItem(
        id: id ?? this.id,
        title: title ?? this.title,
        luong: luong ?? this.luong,
        image: image ?? this.image,
        diaChi: diaChi ?? this.diaChi, // Cập nhật thông tin địa chỉ
        user: user ?? this.user,
        creatorId: creatorId ?? this.creatorId,
        jobId: jobId ?? this.jobId,
        status: status ?? this.status // Thêm trường creatorId
        );
  }

  @override
  String toString() {
    return 'CartItem{id: $id,jobId: $jobId, title: $title, luong: $luong, image: $image, diaChi: $diaChi, user: $user, creatorId: $creatorId}';
  }
}
