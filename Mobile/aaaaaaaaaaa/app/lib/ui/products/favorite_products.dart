import 'package:flutter/material.dart';
import '../../ui/products/products_manager.dart';
import 'package:provider/provider.dart';
import 'products_grid.dart';
import '../orders/orders_screen.dart';
import '../auth/auth_manager.dart';

class FavoriteScreen extends StatefulWidget {
  static const routeName = '/favorite-products';
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenScreenState();
}

class _FavoriteScreenScreenState extends State<FavoriteScreen> {
  int _currentIndex = 1;
  late Future<void> _fetchJobs;

  @override
  void initState() {
    super.initState();
    _fetchJobs = context.read<JobsManager>().fetchJobs();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Your favorites'),
      ),
      body: FutureBuilder(
        future: _fetchJobs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const JobsGrid(true);
          }
          return const Center(
            child: CircularProgressIndicator(),
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
