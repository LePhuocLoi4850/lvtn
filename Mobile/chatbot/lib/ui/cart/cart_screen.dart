import 'package:flutter/material.dart';
// import '../orders/order_manager.dart';
import 'package:provider/provider.dart';

import 'cart_manager.dart';
import 'cart_item_card.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartManager>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your carts'),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Expanded(
            child: buildCartDetails(cart),
          ),
          buildCartSummary(cart, context),
        ],
      ),
    );
  }

  Widget buildCartDetails(CartManager cart) {
    return ListView(
      children: cart.jobEntries
          .map(
            (entry) => CartItemCard(
              productId: entry.key,
              cardItem: entry.value,
            ),
          )
          .toList(),
    );
  }

  Widget buildCartSummary(CartManager cart, BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Tổng thanh toán',
              style: TextStyle(fontSize: 20),
            ),
            const Spacer(),
            Chip(
              label: Text(
                '${cart.totalAmount.toStringAsFixed(2)} vnđ',
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            TextButton(
              onPressed: cart.totalAmount <= 0
                  ? null
                  : () {
                      // context.read<OrdersManager>().addOrder(
                      //       cart.jobs,
                      //       cart.totalAmount,
                      //     );
                      // cart.clearAllItems();
                    },
              style: TextButton.styleFrom(
                textStyle: TextStyle(color: Theme.of(context).primaryColor),
              ),
              child: const Text('Mua hàng'),
            )
          ],
        ),
      ),
    );
  }
}
