import 'package:flutter/material.dart';
import '../../../models/user.dart';
import 'edit_user_screen.dart';

class UserProductListTile extends StatelessWidget {
  final UserData userData;
  const UserProductListTile(
    this.userData, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(
              EditUserScreen.routeName,
              arguments: userData.userId,
            );
          },
          leading:
              const Icon(Icons.person_2_outlined, size: 38, color: Colors.grey),
          title: const Text(
            'Thông tin tài khoản',
            style: TextStyle(fontSize: 20),
          ),
          trailing: const Icon(Icons.keyboard_arrow_right),
        ),
        const Divider(),
        ListTile(
          onTap: () {},
          leading: Icon(Icons.exit_to_app,
              size: 38, color: Colors.grey), // Biểu tượng trước
          title: const Text(
            'Đăng xuất',
            style: TextStyle(fontSize: 20),
          ),
          trailing: const Icon(Icons.keyboard_arrow_right),
        ),
      ],
    );
  }
}
