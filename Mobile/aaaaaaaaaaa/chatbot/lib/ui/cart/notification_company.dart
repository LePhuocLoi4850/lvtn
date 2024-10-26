import 'package:chatbot/models/ring.dart';
import 'package:chatbot/ui/cart/notification_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationCompany extends StatelessWidget {
  final String notification;
  final Ring cardItem;

  const NotificationCompany({
    required this.notification,
    required this.cardItem,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    String notification = '';

    if (cardItem.status == 'waiting') {
      notification = ' Đã ứng tuyển';
    } else if (cardItem.status == 'rejected') {
      notification = 'Đã từ chối thành công hồ sơ của ';
    } else if (cardItem.status == 'accepted') {
      notification = 'Đã duyệt hồ sơ của ';
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
            _buildAcceptedRejectedNotification(notification)
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
                    Expanded(
                      child: Text(
                        notification + ' ' + cardItem.user.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 2, // Giới hạn số dòng hiển thị
                        overflow: TextOverflow
                            .ellipsis, // Hiển thị dấu chấm nếu văn bản quá dài
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
