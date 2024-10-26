import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'user_grid_title.dart';
import 'users_manager.dart';
import '../../models/user.dart';

class UsersGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.select<UsersManager, List<UserData>>(
        (usersManager) => usersManager.item);
    return ListView(
      children: [
        Allusers(itemCount: user.length, user: user),
      ],
    );
  }
}

class Allusers extends StatelessWidget {
  const Allusers({
    Key? key,
    required this.user,
    required int itemCount,
  }) : super(key: key);

  final List<UserData> user;

  @override
  Widget build(BuildContext context) {
    final users = context.select<UsersManager, List<UserData>>(
      (usersManager) =>
          usersManager.item.where((user) => user.level == 'user').toList(),
    );

    final listViewHeight = MediaQuery.of(context).size.height * 1;

    return SizedBox(
      height: listViewHeight,
      child: ListView.builder(
        itemCount: users.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, i) {
          return Container(
            width: 380,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border:
                  Border.all(color: const Color.fromARGB(255, 200, 200, 200)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: UserGridTile(users[i]),
          );
        },
      ),
    );
  }
}