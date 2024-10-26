// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../models/user.dart';

// class ProfileDetailPage extends StatefulWidget {
//   static const routeName = '/profile-detail';
//   ProfileDetailPage(
//     UserData? _userData, {
//     super.key,
//   }) {
//     if (_userData == null) {
//       this._userData = UserData(
//           userId: 'userId',
//           email: 'email',
//           level: 'level',
//           name: 'name',
//           phone: 'phone',
//           ngaysinh: 'ngaysinh',
//           gioitinh: 'gioitinh',
//           diachi: 'diachi');
//     } else {
//       this._userData = _userData;
//     }
//   }
//   late final UserData _userData;
//   @override
//   _ProfileDetailPageState createState() => _ProfileDetailPageState();
// }

// class _ProfileDetailPageState extends State<ProfileDetailPage> {
//   UserData? _userData;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }

//   Future<void> _loadUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final email = prefs.getString('email');
//     final name = prefs.getString('name');
//     final phone = prefs.getString('phone');
//     final diachi = prefs.getString('address');
//     final ngaysinh = prefs.getString('ngaysinh');
//     final gioitinh = prefs.getString('gioitinh');

//     setState(() {
//       // Khởi tạo đối tượng UserData với dữ liệu lấy được
//       _userData = UserData(
//         email: email ?? '',
//         name: name ?? '',
//         phone: phone ?? '',
//         diachi: diachi ?? '',
//         ngaysinh: ngaysinh ?? '',
//         gioitinh: gioitinh ?? '',
//         userId: '',
//         level: '',
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Sử dụng _userData để hiển thị thông tin người dùng trong giao diện người dùng
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('Thông tin tài khoản'),
//       ),
//       body: _userData != null
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text('Email: ${_userData!.email}'),
//                   Text('Name: ${_userData!.name}'),
//                   Text('gioitinh: ${_userData!.gioitinh}'),
//                   Text('Phone: ${_userData!.phone}'),
//                   Text('ngaysinh: ${_userData!.ngaysinh}'),
//                 ],
//               ),
//             )
//           : CircularProgressIndicator(),
//     );
//   }
// }
