import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../user/users_manager.dart';
import 'company_grid_title.dart';

class ListUser extends StatelessWidget {
  const ListUser({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select<UsersManager, List<UserData>>(
        (usersManager) => usersManager.item);
    return ListView.builder(
      padding: const EdgeInsets.all(5.0),
      itemCount: user.length,
      itemExtent: 200,
      itemBuilder: (ctx, i) => Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 200, 200, 200)),
            borderRadius: BorderRadius.circular(8)),
        child: UserGridTile(user[i]),
      ),
    );
  }
}
