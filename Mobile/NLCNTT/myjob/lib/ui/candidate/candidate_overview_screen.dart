import 'package:flutter/material.dart';
import '../shared/app_drawer.dart';
import 'candidate_grid.dart';

enum FilterOptions { favorites, all }

class CandidateOverviewScreen extends StatefulWidget {
  static const routeName = '/candidate';

  const CandidateOverviewScreen({super.key});

  @override
  State<CandidateOverviewScreen> createState() =>
      _CandidateOverviewScreenState();
}

class _CandidateOverviewScreenState extends State<CandidateOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          buildShoppingCartIcon(),
        ],
      ),
      drawer: const AppDrawer(),
      body: CandidateGrid(),
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
