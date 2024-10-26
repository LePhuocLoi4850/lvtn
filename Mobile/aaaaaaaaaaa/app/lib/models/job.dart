import 'package:flutter/foundation.dart';

class Job {
  final String? id;
  final String title;
  final String imageUrl;
  final double luong;
  final String loai;
  final String diachi;
  final String soluong;
  final String lich;
  final String gioitinh;
  final String tuoi;
  final String hocvan;
  final String kinhnghiem;
  final String description;
  final String yeucaukhac;
  final String phucloi;
  final ValueNotifier<bool> _isFavorite;

  Job({
    this.id,
    required this.title,
    required this.imageUrl,
    required this.luong,
    required this.loai,
    required this.diachi,
    required this.soluong,
    required this.lich,
    required this.gioitinh,
    required this.tuoi,
    required this.hocvan,
    required this.kinhnghiem,
    required this.description,
    required this.yeucaukhac,
    required this.phucloi,
    isFavorite = true,
  }) : _isFavorite = ValueNotifier(isFavorite);

  set isFavorite(bool newValue) {
    _isFavorite.value = newValue;
  }

  bool get isFavorite {
    return _isFavorite.value;
  }

  ValueNotifier<bool> get isFavoriteListenable {
    return _isFavorite;
  }

  Job copyWith({
    String? id,
    String? title,
    String? imageUrl,
    double? luong,
    String? loai,
    String? diachi,
    String? soluong,
    String? lich,
    String? gioitinh,
    String? tuoi,
    String? hocvan,
    String? kinhnghiem,
    String? description,
    String? yeucaukhac,
    String? phucloi,
    bool? isFavorite,
  }) {
    return Job(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      luong: luong ?? this.luong,
      loai: loai ?? this.loai,
      diachi: diachi ?? this.diachi,
      soluong: soluong ?? this.soluong,
      lich: lich ?? this.lich,
      gioitinh: gioitinh ?? this.gioitinh,
      tuoi: tuoi ?? this.tuoi,
      hocvan: hocvan ?? this.hocvan,
      kinhnghiem: kinhnghiem ?? this.kinhnghiem,
      description: description ?? this.description,
      yeucaukhac: yeucaukhac ?? this.yeucaukhac,
      phucloi: phucloi ?? this.phucloi,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'luong': luong,
      'loai': loai,
      'diachi': diachi,
      'soluong': soluong,
      'lich': lich,
      'gioitinh': gioitinh,
      'tuoi': tuoi,
      'hocvan': hocvan,
      'kinhnghiem': kinhnghiem,
      'description': description,
      'yeucaukhac': yeucaukhac,
      'phucloi': phucloi,
    };
  }

  static Job fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      luong: json['luong'],
      loai: json['loai'],
      diachi: json['diachi'],
      soluong: json['soluong'],
      lich: json['lich'],
      gioitinh: json['gioitinh'],
      tuoi: json['tuoi'],
      hocvan: json['hocvan'],
      kinhnghiem: json['kinhnghiem'],
      description: json['description'],
      yeucaukhac: json['yeucaukhac'],
      phucloi: json['phucloi'],
    );
  }
}
// class Job {
//   final String? id;
//   final String title;
//   final String imageUrl;
//   final String luong;
//   final String loai;
//   final String soluong;
//   final String lich;
//   final String gioitinh;
//   final String tuoi;
//   final String hocvan;
//   final String kinhnghiem;
//   final String description;
//   final String yeucaukhac;
//   final String phucloi;
//   final AuthToken userId;
//   final ValueNotifier<bool> _isFavorite;

//   Job({
//     this.id,
//     required this.title,
//     required this.imageUrl,
//     required this.luong,
//     required this.loai,
//     required this.soluong,
//     required this.lich,
//     required this.gioitinh,
//     required this.tuoi,
//     required this.hocvan,
//     required this.kinhnghiem,
//     required this.description,
//     required this.yeucaukhac,
//     required this.phucloi,
//     required this.userId,
//     // bool isFavorite = false,
//     isFavorite = false,
//   }) : _isFavorite = ValueNotifier(isFavorite);

//   set isFavorite(bool newValue) {
//     _isFavorite.value = newValue;
//   }

//   bool get isFavorite {
//     return _isFavorite.value;
//   }

//   ValueNotifier<bool> get isFavoriteListenable {
//     return _isFavorite;
//   }

//   Job copyWith({
//     String? id,
//     String? title,
//     String? imageUrl,
//     String? luong,
//     String? loai,
//     String? soluong,
//     String? lich,
//     String? gioitinh,
//     String? tuoi,
//     String? hocvan,
//     String? kinhnghiem,
//     String? description,
//     String? yeucaukhac,
//     String? phucloi,
//     AuthToken? userId,
//   }) {
//     return Job(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       imageUrl: imageUrl ?? this.imageUrl,
//       luong: luong ?? this.luong,
//       loai: loai ?? this.loai,
//       soluong: soluong ?? this.soluong,
//       lich: lich ?? this.lich,
//       gioitinh: gioitinh ?? this.gioitinh,
//       tuoi: tuoi ?? this.tuoi,
//       hocvan: hocvan ?? this.hocvan,
//       kinhnghiem: kinhnghiem ?? this.kinhnghiem,
//       description: description ?? this.description,
//       yeucaukhac: yeucaukhac ?? this.yeucaukhac,
//       phucloi: phucloi ?? this.phucloi,
//       userId: userId ?? this.userId,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'imageUrl': imageUrl,
//       'luong': luong,
//       'loai': loai,
//       'soluong': soluong,
//       'lich': lich,
//       'gioitinh': gioitinh,
//       'tuoi': tuoi,
//       'hocvan': hocvan,
//       'kinhnghiem': kinhnghiem,
//       'description': description,
//       'yeucaukhac': yeucaukhac,
//       'phucloi': phucloi,
//       'userId': userId.toJson(),
//     };
//   }

//   static Job fromJson(Map<String, dynamic> json) {
//     return Job(
//       id: json['id'],
//       title: json['title'],
//       imageUrl: json['imageUrl'],
//       luong: json['luong'],
//       loai: json['loai'],
//       soluong: json['soluong'],
//       lich: json['lich'],
//       gioitinh: json['gioitinh'],
//       tuoi: json['tuoi'],
//       hocvan: json['hocvan'],
//       kinhnghiem: json['kinhnghiem'],
//       description: json['description'],
//       yeucaukhac: json['yeucaukhac'],
//       phucloi: json['phucloi'],
//       userId: AuthToken.fromJson(json['userId']),
//     );
//   }
// }

