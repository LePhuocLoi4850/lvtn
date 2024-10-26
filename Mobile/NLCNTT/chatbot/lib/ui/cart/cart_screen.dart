// import 'package:chatbot/ui/cart/notification_manager.dart';
import 'package:flutter/material.dart';
// import '../orders/order_manager.dart';
import 'package:provider/provider.dart';
import 'cart_manager.dart';
import 'notification.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _showMale(BuildContext ctx) {
    showModalBottomSheet(
      elevation: 10,
      context: ctx,
      builder: (ctx) => SizedBox(
        width: 410,
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              decoration: const BoxDecoration(color: Colors.grey),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tùy chọn',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Đánh dấu đã đọc',
                    style: TextStyle(fontSize: 24),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notification = context.watch<CartManager>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông báo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: <Widget>[buildSettingButton(context)],
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Expanded(
            child: buildCartDetails(notification),
          ),
        ],
      ),
    );
  }

  Widget buildSettingButton(BuildContext context) {
    return IconButton(
      onPressed: () => _showMale(context),
      icon: const Icon(Icons.settings),
    );
  }

  Widget buildCartDetails(CartManager notification) {
    return ListView(
      children: notification.jobEntries
          .map(
            (entry) => MyNotification(
              notification: entry.key,
              cardItem: entry.value,
            ),
          )
          .toList(),
    );
  }
}
