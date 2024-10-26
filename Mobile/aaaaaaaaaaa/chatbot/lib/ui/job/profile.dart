// import 'package:chatbot/models/user.dart';
import 'package:chatbot/ui/share/line_top.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../auth/auth_manager.dart';
import '../user_provider.dart';
import 'profile_detail.dart';
import 'profile_detail_company.dart';
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
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Container(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  child: Icon(
                    Icons.account_circle,
                    size: 60,
                    color: Colors.blue[600],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.name ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        softWrap: true,
                      ),
                      Text(
                        user?.email ?? '',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
              ],
            ),
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
                        onTap: () {
                          if (user?.level == 'user') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileDetail()),
                            );
                          } else if (user?.level == 'company') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileDetailCompany()),
                            );
                          }
                        },
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
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 18,
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
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 18,
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
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 18,
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
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 18,
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
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 18,
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
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 18,
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
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 18,
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
                        title: Text(
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
