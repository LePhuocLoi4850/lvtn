import 'package:flutter/material.dart';
import '../shared/app_drawer.dart';
import 'company_grid.dart';

enum FilterOptions { favorites, all }

class CompanyOverviewScreen extends StatefulWidget {
  static const routeName = '/company';
  const CompanyOverviewScreen({super.key});

  @override
  State<CompanyOverviewScreen> createState() => _CompanyOverviewScreenState();
}

class _CompanyOverviewScreenState extends State<CompanyOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          buildShoppingCartIcon(),
        ],
      ),
      drawer: const AppDrawer(),
      body: const CompanyGrid(),
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
