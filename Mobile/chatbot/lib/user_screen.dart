import 'package:flutter/material.dart';

import 'ui/job/job_overview_screen.dart';
import 'ui/job/profile.dart';
import 'ui/job/search_app.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _page = [
    const JobsOverviewScreen(),
    const SearchJobsScreen(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
              color: Colors.blue,
            ),
            label: 'Trang Chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 30,
              color: Colors.blue,
            ),
            label: 'Tìm Việc',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30,
              color: Colors.blue,
            ),
            label: 'Tài Khoản',
          ),
        ],
      ),
    );
  }
}
