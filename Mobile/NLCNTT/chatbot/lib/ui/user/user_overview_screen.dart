import 'dart:async';
import 'package:flutter/material.dart';
import 'users_manager.dart';
import 'package:provider/provider.dart';
import 'user_grid.dart';

class UsersOverviewScreen extends StatefulWidget {
  static const routeName = '/user';
  const UsersOverviewScreen({super.key});

  @override
  State<UsersOverviewScreen> createState() => _UsersOverviewScreenState();
}

class _UsersOverviewScreenState extends State<UsersOverviewScreen> {
  late Future<void> _fetchUsers;
  @override
  void initState() {
    super.initState();
    _fetchUsers = context.read<UsersManager>().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Danh Sách Ứng Viên',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: FutureBuilder(
              future: _fetchUsers,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return UsersGrid();
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
