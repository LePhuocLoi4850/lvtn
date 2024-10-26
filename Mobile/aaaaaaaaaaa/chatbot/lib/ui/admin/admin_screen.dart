import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/auth_manager.dart';
import '../job/search_app.dart';
import '../job_provider.dart';
import '../user/user_screen.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => JobProvider()), // Provide JobProvider
        ],
        child: const AdminScreenBody(),
      ),
    );
  }
}

class AdminScreenBody extends StatefulWidget {
  const AdminScreenBody({Key? key}) : super(key: key);

  @override
  _AdminScreenBodyState createState() => _AdminScreenBodyState();
}

class _AdminScreenBodyState extends State<AdminScreenBody> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          UsersOverviewScreen(),
          UsersOverviewScreen(),
          SearchJobsScreen(),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70.0),
        child: FloatingActionButton(
          onPressed: () {
            context.read<AuthManager>().logout();
            Navigator.of(context).pushReplacementNamed('/');
          },
          child: Icon(Icons.logout_rounded),
          backgroundColor: Colors.blue, // Màu nền của nút
          elevation: 2.0, // Độ nổi của nút
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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
            label: 'User',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month,
              size: 30,
            ),
            label: 'Company',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            label: 'Job',
          ),
        ],
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
