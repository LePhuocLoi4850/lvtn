import 'package:flutter/material.dart';
import '../shared/app_drawer.dart';
import 'admin_grid.dart';

enum FilterOptions { favorites, all }

class AdminOverviewScreen extends StatefulWidget {
  static const routeName = '/admin';

  const AdminOverviewScreen({super.key});

  @override
  State<AdminOverviewScreen> createState() => _AdminOverviewScreenState();
}

class _AdminOverviewScreenState extends State<AdminOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          buildShoppingCartIcon(),
        ],
      ),
      drawer: const AppDrawer(),
      body: AdminGrid(),
    );
  }

  Widget buildShoppingCartIcon() {
    return IconButton(
      icon: const Icon(
        Icons.notifications_rounded,
      ),
      color: Colors.purple,
      onPressed: () {
        print('Go to Notification');
      },
    );
  }
}
