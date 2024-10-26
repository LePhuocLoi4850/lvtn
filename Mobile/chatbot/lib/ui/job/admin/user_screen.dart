import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';
import '../../auth/auth_manager.dart';
import '../search_app.dart';

class UserScreen extends StatefulWidget {
  static const routeName = '/profile';
  final UserData userData;

  UserScreen({required this.userData});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Detail'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${widget.userData.name}',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'Email: ${widget.userData.email}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Ngày sinh: ${widget.userData.ngaysinh}',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottom(
        currentIndex: _currentIndex,
      ),
    );
  }
}

class bottom extends StatelessWidget {
  const bottom({
    super.key,
    required int currentIndex,
  }) : _currentIndex = currentIndex;

  final int _currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      onTap: (index) {
        if (_currentIndex != index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushReplacementNamed('/');
              break;
            case 1:
              Navigator.of(context)
                  .pushReplacementNamed(SearchJobsScreen.routeName);
              break;
            case 2:
              Navigator.of(context).pushNamed(UserScreen.routeName);
              break;
            case 3:
              context.read<AuthManager>().logout();
          }
        } else if (index == 0) {
          // Reload logic for Home screen
          Navigator.of(context).pushReplacementNamed('/');
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: FaIcon(
            FontAwesomeIcons.house,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(
            FontAwesomeIcons.magnifyingGlass,
            color: Color.fromARGB(255, 178, 176, 178),
          ),
          label: 'Tìm ứng viên',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(
            FontAwesomeIcons.solidPaperPlane,
            color: Colors.blue,
          ),
          label: 'Đăng tin',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.rightFromBracket,
              color: Color.fromARGB(255, 178, 176, 178)),
          label: 'Log out',
        ),
      ],
    );
  }
}
