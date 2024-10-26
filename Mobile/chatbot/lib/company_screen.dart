import 'package:chatbot/models/job.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'ui/admin/edit_product_screen.dart';
import 'ui/company/company_overview_screen.dart';
import 'ui/company/search_user.dart';
import 'ui/job/profile.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanycreenState();
}

class _CompanycreenState extends State<CompanyScreen> {
  int _selectedIndex = 0;

  static Job? get job => null;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _page = [
    const CompanyOverviewScreen(),
    const SearchUserScreen(),
    EditJobScreen(job),
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
            icon: FaIcon(
              FontAwesomeIcons.house,
              size: 24,
              color: Colors.blue,
            ),
            label: 'Trang Chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_search_sharp,
              size: 34,
              color: Colors.blue,
            ),
            label: 'Tìm ứng viên',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.solidPaperPlane,
              size: 24,
              color: Colors.blue,
            ),
            label: 'Đăng tin',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.solidUser,
              size: 24,
              color: Colors.blue,
            ),
            label: 'Tài Khoản',
          ),
        ],
      ),
    );
  }
}
