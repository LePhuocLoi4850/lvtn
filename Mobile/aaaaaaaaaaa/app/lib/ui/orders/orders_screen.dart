import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'order_item_card.dart';
import 'order_manager.dart';
import '../products/favorite_products.dart';
import '../auth/auth_manager.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';
  const OrdersScreen({super.key});
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    print('building orders');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Your Orders'),
      ),
      body: Consumer<OrdersManager>(
        builder: (ctx, ordersManager, child) {
          return ListView.builder(
            itemCount: ordersManager.orderCount,
            itemBuilder: (ctx, i) => OrderItemCard(ordersManager.orders[i]),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.of(context).pushReplacementNamed('/');
              break;
            case 1:
              Navigator.of(context)
                  .pushReplacementNamed(FavoriteScreen.routeName);
              break;
            case 2:
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
              break;
            case 3:
              context.read<AuthManager>().logout();
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Log out',
          ),
        ],
      ),
    );
  }
}
