import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/job/job_overview_screen.dart';
import 'ui/job/profile.dart';
import 'ui/job/search_app.dart';
import 'ui/job_provider.dart';
import 'ui/mycv/my_cv.dart'; // Import JobProvider

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider(
        // Sử dụng MultiProvider để lắng nghe nhiều provider
        providers: [
          ChangeNotifierProvider(
              create: (_) => JobProvider()), // Provide JobProvider
          // Các Provider khác nếu có
        ],
        child: const MainScreenBody(),
      ),
    );
  }
}

class MainScreenBody extends StatefulWidget {
  const MainScreenBody({Key? key}) : super(key: key);

  @override
  _MainScreenBodyState createState() => _MainScreenBodyState();
}

class _MainScreenBodyState extends State<MainScreenBody> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const JobsOverviewScreen(),
          const MyCV(),
          const SearchJobsScreen(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: 'Trang Chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month,
              size: 30,
            ),
            label: 'CV của tôi',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            label: 'Tìm việc',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30,
            ),
            label: 'Tài Khoản',
          ),
        ],
      ),
    );
  }
}
