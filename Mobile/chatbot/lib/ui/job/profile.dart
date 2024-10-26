// import 'package:chatbot/models/user.dart';
import 'package:chatbot/ui/share/line_top.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../auth/auth_manager.dart';
// import 'profile_detail.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile-job';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tài khoản',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        bottom: const LineTop(),
      ),
      body: Container(
        color: Color.fromARGB(255, 234, 234, 234),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: 400,
                height: 209,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: const Color.fromARGB(255, 230, 230, 230))),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FaIcon(
                                FontAwesomeIcons.solidUser,
                                color: Colors.blue[700],
                              ),
                            ),
                            const Text(
                              'Thông tin tài khoản',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FaIcon(
                                FontAwesomeIcons.mobileScreenButton,
                                color: Colors.blue[700],
                              ),
                            ),
                            const Text(
                              'Thêm số điện thoại',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FaIcon(
                                FontAwesomeIcons.universalAccess,
                                color: Colors.blue[700],
                              ),
                            ),
                            const Text(
                              'Xác thực tài khoản',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: 400,
                height: 209,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: const Color.fromARGB(255, 230, 230, 230))),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FaIcon(
                                FontAwesomeIcons.fileInvoice,
                                color: Colors.blue[700],
                              ),
                            ),
                            const Text(
                              'Điều khoản dịch vụ',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FaIcon(
                                FontAwesomeIcons.fileShield,
                                color: Colors.blue[700],
                              ),
                            ),
                            const Text(
                              'Chính sách bảo mật',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FaIcon(
                                FontAwesomeIcons.book,
                                color: Colors.blue[700],
                              ),
                            ),
                            const Text(
                              'HƯớng dẫn sử dụng',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: 400,
                height: 160,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: const Color.fromARGB(255, 230, 230, 230))),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FaIcon(
                                FontAwesomeIcons.circleMinus,
                                color: Colors.red[700],
                              ),
                            ),
                            const Text(
                              'Xóa tài khoản',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        onTap: () {
                          context.read<AuthManager>().logout();
                          Navigator.of(context).pushReplacementNamed('/');
                        },
                        leading: const FaIcon(
                          FontAwesomeIcons.rightFromBracket,
                          color: Colors.red,
                        ),
                        title: const Text(
                          'Đăng xuất',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLogoutButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<AuthManager>().logout();
        Navigator.of(context).pushReplacementNamed('/');
      },
      icon: const Icon(Icons.exit_to_app),
    );
  }
}


// import 'package:flutter/material.dart';
// import '../../main_screen.dart';
// import '../../models/user.dart';
// import '../../services/auth_service.dart';
// import '../company/company_overview_screen.dart';

// class ProfilePage extends StatefulWidget {
//   static const routeName = '/profile';

//   final String userId;
//   final String email;

//   const ProfilePage({
//     Key? key,
//     required this.userId,
//     required this.email,
//   }) : super(key: key);

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final AuthService _authService = AuthService();
//   UserData? _userData;
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _phoneController = TextEditingController();
//   TextEditingController _ngaysinhController = TextEditingController();
//   TextEditingController _gioitinhController = TextEditingController();
//   TextEditingController _diachiController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }

//   Future<void> _loadUserData() async {
//     try {
//       UserData? userData = await _authService.getUserData(widget.userId);
//       if (!mounted) {
//         return;
//       }
//       setState(() {
//         _userData = userData;
//         _nameController.text = _userData!.name;
//         _phoneController.text = _userData!.phone;
//         _ngaysinhController.text = _userData!.ngaysinh;
//         _gioitinhController.text = _userData!.gioitinh;
//         _diachiController.text = _userData!.diachi;
//       });
//     } catch (error) {
//       // Xử lý lỗi nếu cần
//       print('Error loading user data: $error');
//     }
//   }

//   void navigateToProfilePage(BuildContext? context, UserData userData) {
//     if (context != null) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ProfilePage(
//             userId: userData.userId,
//             email: userData.email,
//           ),
//         ),
//       );
//     } else {
//       print('Error: context is null');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Update Profile'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (_userData != null) ...[
//               TextFormField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(labelText: 'Name'),
//               ),
//               TextFormField(
//                 controller: _phoneController,
//                 decoration: const InputDecoration(labelText: 'Phone'),
//               ),
//               TextFormField(
//                 controller: _ngaysinhController,
//                 decoration: const InputDecoration(labelText: 'Ngày sinh'),
//               ),
//               TextFormField(
//                 controller: _gioitinhController,
//                 decoration: const InputDecoration(labelText: 'Giới tính'),
//               ),
//               TextFormField(
//                 controller: _diachiController,
//                 decoration: const InputDecoration(labelText: 'Địa chỉ'),
//               ),
//             ],
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: ElevatedButton(
//           onPressed: () {
//             _saveUserData();
//           },
//           child: const Text('Submit'),
//         ),
//       ),
//     );
//   }

//   Future<void> _saveUserData() async {
//     try {
//       UserData updatedUserData = _userData!.copyWith(
//         name: _nameController.text,
//         phone: _phoneController.text,
//         ngaysinh: _ngaysinhController.text,
//         gioitinh: _gioitinhController.text,
//         diachi: _diachiController.text,
//       );

//       await _authService.updateUserData(updatedUserData);

//       _redirectToNextScreen();
//     } catch (error) {
//       print('Error saving user data: $error');
//     }
//   }

//   void _redirectToNextScreen() {
//     if (_userData!.level == 'user') {
//       _redirectToJobOverviewScreen();
//     } else {
//       _redirectToCompanyOverviewScreen();
//     }
//   }

//   void _redirectToJobOverviewScreen() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const MainScreen(),
//       ),
//     );
//   }

//   void _redirectToCompanyOverviewScreen() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const CompanyOverviewScreen(),
//       ),
//     );
//   }
// }
