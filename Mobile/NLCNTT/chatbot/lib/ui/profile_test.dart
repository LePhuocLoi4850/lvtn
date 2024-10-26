import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/auth_manager.dart';
import 'user_provider.dart';

class ProfileTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: <Widget>[
          buildLogoutButton(context),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Thông tin cá nhân',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text('Email: ${user?.email ?? ''}'),
            Text('Số điện thoại: ${user?.phone ?? ''}'),
            Text('Số điện thoại: ${user?.userId ?? ''}'),
            Text('Số điện thoại: ${user?.diachi ?? ''}'),
            Text('Số điện thoại: ${user?.ngaysinh ?? ''}'),
            Text('Số điện thoại: ${user?.career ?? ''}'),
          ],
        ),
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
