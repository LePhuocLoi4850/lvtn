import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../products/favorite_products.dart';
import 'admin_product_list_tile.dart';
import '../products/products_manager.dart';
import 'edit_product_screen.dart';
import '../auth/auth_manager.dart';

class UserJobsScreen extends StatefulWidget {
  static const routeName = '/user-products';
  const UserJobsScreen({super.key});

  @override
  State<UserJobsScreen> createState() => _UserJobsScreenState();
}

class _UserJobsScreenState extends State<UserJobsScreen> {
  @override
  Widget build(BuildContext context) {
    int _currentIndex = 2;
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: const Text('jobs'),
        actions: <Widget>[
          buildAddButton(context),
          logout(context),
        ],
      ),
      body: FutureBuilder(
        future: context.read<JobsManager>().fetchJobs(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: () => context.read<JobsManager>().fetchJobs(),
            child: buildUserJobListView(),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        // onTap: (index) {
        //   setState(() {
        //     _currentIndex = index;
        //   });
        //   switch (index) {
        //     case 0:
        //       Navigator.of(context).pushReplacementNamed('/');
        //       break;
        //     case 1:
        //       Navigator.of(context)
        //           .pushReplacementNamed(FavoriteScreen.routeName);
        //       break;
        //     case 2:
        //       Navigator.of(context)
        //           .pushReplacementNamed(OrdersScreen.routeName);
        //       break;
        //     case 3:
        //       context.read<AuthManager>().logout();
        //   }
        // },
        onTap: (index) {
          if (_currentIndex != index) {
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
                    .pushReplacementNamed(UserJobsScreen.routeName);
                break;
              case 3:
                context.read<AuthManager>().logout();
            }
          } else if (index == 0) {
            // Reload logic for Home screen
            Navigator.of(context).pushReplacementNamed('/');
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

  Widget buildUserJobListView() {
    return Consumer<JobsManager>(
      builder: (ctx, jobsManager, child) {
        return ListView.builder(
          itemCount: jobsManager.itemCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              UserJobListTile(
                jobsManager.item[i],
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditJobScreen.routeName,
        );
      },
      icon: const Icon(Icons.add),
    );
  }

  Widget logout(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<AuthManager>().logout();
      },
      icon: const Icon(Icons.exit_to_app),
    );
  }
}
