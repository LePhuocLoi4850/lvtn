import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../user/users_manager.dart';
import 'company_grid_title.dart';
import '../../models/user.dart';

class CompanysGrid extends StatelessWidget {
  const CompanysGrid({super.key});

  @override
  // Widget build(BuildContext context) {
  //   final user = context.select<usersManager, List<user>>((usersManager) =>
  //       showFavorites ? usersManager.favoriteItems : usersManager.item);
  //   return ListView.builder(
  //     padding: const EdgeInsets.all(5.0),
  //     itemCount: 2,
  //     itemExtent: 200,
  //     itemBuilder: (ctx, i) => Container(
  //       margin: const EdgeInsets.all(10),
  //       decoration: BoxDecoration(
  //           border: Border.all(color: const Color.fromARGB(255, 200, 200, 200)),
  //           borderRadius: BorderRadius.circular(8)),
  //       child: userGridTile(user[i]),
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    final user = context.select<UsersManager, List<UserData>>(
        (usersManager) => usersManager.item);

    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 18.0, top: 30),
          child: Text(
            'Việc làm phù hợp',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 20, 121, 203)),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: user.length,
            itemBuilder: (ctx, i) {
              return Container(
                width: 390,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 200, 200, 200)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: UserGridTile(user[i]),
              );
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 18.0, top: 30),
          child: Text(
            'Việc làm Hot',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 20, 121, 203)),
          ),
        ),
        SizedBox(
          height: 200,
          width: 400,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: user.length,
            itemBuilder: (ctx, i) {
              return Container(
                width: 380,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 200, 200, 200)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: UserGridTile(user[i]),
              );
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 18.0, top: 30),
          child: Text(
            'Việc làm mới nhất',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 20, 121, 203)),
          ),
        ),
        Allusers(itemCount: user.length, user: user),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: SizedBox(
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/Search-user');
              },
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Colors.blue, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Xem tất cả việc làm',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 18.0, top: 20),
          child: Text(
            'Ngành nghề nổi bậc',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 20, 121, 203)),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: user.length,
            itemBuilder: (ctx, i) {
              return Container(
                width: 200,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 200, 200, 200)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: UserGridTile(user[i]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class Allusers extends StatelessWidget {
  const Allusers({
    Key? key,
    required this.itemCount,
    required this.user,
  }) : super(key: key);

  final int itemCount;
  final List<UserData> user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 775,
      child: ListView.builder(
        itemCount: itemCount,
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
            child: UserGridTile(user[i]),
          );
        },
      ),
    );
  }
}
