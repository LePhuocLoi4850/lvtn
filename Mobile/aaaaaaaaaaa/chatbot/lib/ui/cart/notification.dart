// import 'package:chatbot/ui/cart/notification_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../models/cart_item.dart';

// // import 'notification_manager.dart';
// class MyNotification extends StatelessWidget {
//   final String notification;
//   final CartItem cardItem;

//   const MyNotification({
//     required this.notification,
//     required this.cardItem,
//     super.key,
//   });
//   @override
//   Widget build(BuildContext context) {
//     String notification = '';

//     if (cardItem.status == 'waiting') {
//       notification = 'Thành công';
//     } else if (cardItem.status == 'rejected') {
//       notification = 'Hồ sơ bị từ chối';
//     } else if (cardItem.status == 'accepted') {
//       notification = 'Hồ sơ đã được duyệt';
//     }

//     return Dismissible(
//       key: ValueKey(cardItem.id),
//       background: Container(
//         color: Theme.of(context).colorScheme.error,
//         alignment: Alignment.centerRight,
//         padding: const EdgeInsets.only(right: 20),
//         margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
//         child: const Icon(
//           Icons.delete,
//           color: Colors.white,
//           size: 40,
//         ),
//       ),
//       direction: DismissDirection.endToStart,
//       onDismissed: (direction) {
//         context.read<NotificationManager>().clearNotificationItem(cardItem.id);
//       },
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (cardItem.status ==
//               'accepted') // Hiển thị thông báo mới khi chấp nhận hồ sơ
//             Container(
//               margin: const EdgeInsets.only(bottom: 8),
//               child: Text(
//                 notification,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.green,
//                 ),
//               ),
//             )
//           else if (cardItem.status == 'rejected')
//             Container(
//               margin: const EdgeInsets.only(bottom: 8),
//               child: Text(
//                 notification,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.green,
//                 ),
//               ),
//             ),
//           buildItemCard(notification), // Hiển thị thông báo cũ
//         ],
//       ),
//     );
//   }

//   Widget buildItemCard(String notification) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
//       child: Padding(
//         padding: const EdgeInsets.all(8),
//         child: ListTile(
//           leading: CircleAvatar(
//             backgroundImage: NetworkImage(cardItem.image),
//           ),
//           title: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     cardItem.user.name,
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(width: 2),
//                   Text('ứng tuyển thành công'),
//                 ],
//               ),
//               Text(
//                 'Vị trí: ${cardItem.title}',
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:chatbot/models/ring.dart';
import 'package:chatbot/ui/cart/notification_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyNotification extends StatelessWidget {
  final String notification;
  final Ring cardItem;

  const MyNotification({
    required this.notification,
    required this.cardItem,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    String notification = '';

    if (cardItem.status == 'waiting') {
      notification = 'Thành công';
    } else if (cardItem.status == 'rejected') {
      notification = 'Hồ sơ bị từ chối';
    } else if (cardItem.status == 'accepted') {
      notification = 'Hồ sơ đã được duyệt';
    }

    return Dismissible(
      key: ValueKey(cardItem.id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        context.read<NotificationManager>().clearNotificationItem(cardItem.id);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (cardItem.status == 'waiting')
            _buildWaitingNotification(notification)
          else
            _buildAcceptedRejectedNotification(notification),
        ],
      ),
    );
  }

  Widget _buildWaitingNotification(String notification) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(cardItem.image),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      cardItem.user.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 3),
                    Text(notification),
                  ],
                ),
                Text(
                  'Vị trí: ${cardItem.title}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAcceptedRejectedNotification(String notification) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(cardItem.image),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      cardItem.user.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 3),
                    Text(notification),
                  ],
                ),
                Text(
                  'Vị trí: ${cardItem.title}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(cardItem.image),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    cardItem.user.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 3),
                  Text('Ứng tuyển thành công'),
                ],
              ),
              Text(
                'Vị trí: ${cardItem.title}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
