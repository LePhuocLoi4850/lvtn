import 'dart:async';

import '../../ui/products/favorite_products.dart';
// import '../../ui/products/find_products.dart';

import '../admin/admin_products_screen.dart';
// import '../orders/orders_screen.dart';

import 'package:flutter/material.dart';
import '../../ui/cart/cart_screen.dart';
import '../../ui/products/products_manager.dart';

import 'package:provider/provider.dart';
import 'products_grid.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import '../auth/auth_manager.dart';
import '../cart/cart_manager.dart';
import 'top_right_badge.dart';

class JobsOverviewScreen extends StatefulWidget {
  const JobsOverviewScreen({super.key});

  @override
  State<JobsOverviewScreen> createState() => _JobsOverviewScreenState();
}

class _JobsOverviewScreenState extends State<JobsOverviewScreen> {
  late Future<void> _fetchJobs;
  int _currentIndex = 0;
  final CartManager cartManager = CartManager();
  @override
  void initState() {
    super.initState();
    _fetchJobs = context.read<JobsManager>().fetchJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          buildShoppingCartIcon(),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // const SliverToBoxAdapter(
          //   child: Padding(
          //     padding: EdgeInsets.only(top: 10, bottom: 15),
          //     child: Text(
          //       'DANH MỤC SẢN PHẨM',
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //         fontSize: 24,
          //         fontWeight: FontWeight.w400,
          //       ),
          //     ),
          //   ),
          // ),
          SliverFillRemaining(
            child: FutureBuilder(
              future: _fetchJobs,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return const JobsGrid(false);
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
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

  // Widget buildSlideshow() {
  //   return CarouselSlider(
  //     options: CarouselOptions(
  //       height: 250.0,
  //       autoPlay: true,
  //       enlargeCenterPage: true,
  //       viewportFraction: 0.8,
  //     ),
  //     // items: [
  //     //   'assets/images/1582275730140_540.png',
  //     //   'assets/images/1592967757161_540.png',
  //     //   'assets/images/DT-SachNuaGia.png',
  //     ].map((imagePath) {
  //       return Builder(
  //         builder: (BuildContext context) {
  //           return Container(
  //             width: MediaQuery.of(context).size.width,
  //             margin: const EdgeInsets.symmetric(horizontal: 5.0),
  //             decoration: const BoxDecoration(
  //               color: Colors.blue,
  //             ),
  //             child: Image.asset(
  //               imagePath,
  //               fit: BoxFit.cover,
  //             ),
  //           );
  //         },
  //       );
  //     }).toList(),
  //   );
  // }

  Widget buildShoppingCartIcon() {
    return Consumer<CartManager>(
      builder: (context, cartManager, child) => TopRightBadge(
        data: cartManager.jobCount,
        child: IconButton(
          icon: const Icon(
            Icons.notifications_rounded,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(CartScreen.routeName);
          },
        ),
      ),
    );
  }
}
