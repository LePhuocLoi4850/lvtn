import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/cart_item.dart';
import '../cart/cart_manager.dart';
import '../cart/notification_manager.dart';
import '../user_provider.dart';

class CartItemListPage extends StatefulWidget {
  const CartItemListPage({Key? key}) : super(key: key);

  @override
  _CartItemListPageState createState() => _CartItemListPageState();
}

class _CartItemListPageState extends State<CartItemListPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh Sách Ứng Viên'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Chờ duyệt'),
            Tab(text: 'Đã nhận'),
            Tab(text: 'Từ chối'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabContent(context, "waiting"),
          _buildTabContent(context, "accepted"),
          _buildTabContent(context, "rejected"),
        ],
      ),
    );
  }

  Widget _buildTabContent(BuildContext context, String status) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<CartManager>().fetchUser();
      },
      child: Consumer2<CartManager, UserProvider>(
        builder: (context, cartManager, userProvider, _) {
          final userId = userProvider.user?.userId;
          if (userId != null) {
            final filteredCartItems = cartManager.jobs
                .where((cartItem) =>
                    cartItem.creatorId == userId && cartItem.status == status)
                .toList();
            return ListView.builder(
              itemCount: filteredCartItems.length,
              itemBuilder: (context, index) {
                final cartItem = filteredCartItems[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, top: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 15.0,
                      ),
                      title: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tên: ${cartItem.user.name}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Vị trí: ${cartItem.title}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                      trailing: cartItem.status == "waiting"
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, right: 4),
                                    child: IconButton(
                                      onPressed: () {
                                        _acceptApplication(context, cartItem);
                                      },
                                      icon: Icon(Icons.check),
                                      color: Colors.white,
                                      iconSize: 26,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, right: 4),
                                    child: IconButton(
                                      onPressed: () {
                                        _rejectApplication(context, cartItem);
                                      },
                                      icon: Icon(Icons.close),
                                      color: Colors.white,
                                      iconSize: 26,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('Vui lòng đăng nhập để xem công việc của bạn.'),
            );
          }
        },
      ),
    );
  }

  void _acceptApplication(BuildContext context, CartItem cartItem) {
    context.read<CartManager>().acceptApplication(cartItem);
    context
        .read<NotificationManager>()
        .addNotificationAcceptItem(cartItem, cartItem.user);
  }

  void _rejectApplication(BuildContext context, CartItem cartItem) {
    context.read<CartManager>().rejectApplication(cartItem);
    context
        .read<NotificationManager>()
        .addNotificationRejectItem(cartItem, cartItem.user);
  }
}
