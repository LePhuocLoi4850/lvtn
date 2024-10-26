import 'package:chatbot/models/user.dart';
import 'package:flutter/material.dart';
// import '../../ui/cart/cart_manager.dart';

import 'company_detail_screen.dart';

class UserGridTile extends StatelessWidget {
  const UserGridTile(
    this.user, {
    super.key,
  });
  final UserData user;
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
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 200, 200, 200),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            user.name,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
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
                                        user.email,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.where_to_vote_rounded,
                                            color: Colors.green,
                                            size: 22,
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                user.diachi,
                                                style: const TextStyle(
                                                    fontSize: 17,
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
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.share_location_outlined,
                            color: Colors.amber,
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Text(
                                user.ngaysinh,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.monetization_on,
                            color: Colors.amber,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Text('${user}'),
                          ),
                        ],
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
