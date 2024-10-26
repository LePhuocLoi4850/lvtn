import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import '../../ui/cart/cart_manager.dart';
import '../../models/user.dart';
import '../user/user_detail_screen.dart';

class UserGridTile extends StatelessWidget {
  const UserGridTile(
    this.user, {
    super.key,
  });
  final UserData user;
  int calculateAge(String birthDate) {
    List<String> parts = birthDate.split('/');
    DateTime birthday =
        DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthday.year;
    if (currentDate.month < birthday.month ||
        (currentDate.month == birthday.month &&
            currentDate.day < birthday.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        // footer: buildGridFooterBar(context),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              UserDetailScreen.routeName,
              arguments: user.userId,
            );
          },
          child: Card(
            elevation: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Column(
                                    children: [
                                      Text(
                                        user.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.cake,
                                            color: Colors.amber,
                                            size: 22,
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                '${calculateAge(user.ngaysinh)} Tuổi',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 158, 155, 145)),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const FaIcon(
                                            FontAwesomeIcons.venusMars,
                                            color: Colors.amber,
                                            size: 18,
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                user.gioitinh,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 158, 155, 145)),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.share_location_outlined,
                                            color: Colors.amber,
                                            size: 22,
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                user.diachi,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 158, 155, 145)),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const FaIcon(
                                            FontAwesomeIcons.medal,
                                            color: Colors.amber,
                                            size: 18,
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                'Kinh nghiệm: ${user.phone}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 158, 155, 145)),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
