import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/user-products';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('jobs'),
      ),
      body: Center(
        child: Text('Profile'),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   selectedItemColor: Colors.blue,
      //   unselectedItemColor: Colors.grey,
      //   onTap: (index) {
      //     if (_currentIndex != index) {
      //       switch (index) {
      //         case 0:
      //           Navigator.of(context).pushReplacementNamed('/');
      //           break;
      //       }
      //     } else if (index == 0) {
      //       Navigator.of(context).pushReplacementNamed('/');
      //     }
      //   },
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: FaIcon(
      //         FontAwesomeIcons.house,
      //       ),
      //       label: 'Home',
      //     ),
      //   ],
      // ),
    );
  }
}
