import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import '../shared/app_drawer.dart';
import 'job_grid.dart';
// import './job_manager.dart';

enum FilterOptions { favorites, all }

class JobOverviewScreen extends StatefulWidget {
  const JobOverviewScreen({super.key});

  @override
  State<JobOverviewScreen> createState() => _JobOverviewScreenState();
}

class _JobOverviewScreenState extends State<JobOverviewScreen>
    with SingleTickerProviderStateMixin {
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          buildProductFilterMenu(),
          buildShoppingCartIcon(),
        ],
      ),
      drawer: const AppDrawer(),
      body: JobGrid(_showOnlyFavorites),
      // body: FutureBuilder(
      //   future: _fetchJob,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       return ValueListenableBuilder<bool>(
      //           valueListenable: _showOnlyFavorites,
      //           builder: (context, onlyFavorites, child) {
      //             return JobGrid(onlyFavorites);
      //           });
      //     }
      //     return const Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // ),
    );
  }

  Widget buildShoppingCartIcon() {
    return IconButton(
      icon: const Icon(
        Icons.notifications_rounded,
      ),
      color: Colors.purple,
      onPressed: () {
        print('Go to Notification');
      },
    );
  }

  Widget buildProductFilterMenu() {
    return PopupMenuButton(
      onSelected: (FilterOptions selectedValues) {
        // setState(
        //   () {
        //     if (selectedValues == FilterOptions.favorites) {
        //       _showOnlyFavorites.value = true;
        //     } else {
        //       _showOnlyFavorites.value = false;
        //     }
        //   },
        // );
        setState(() {
          if (selectedValues == FilterOptions.favorites) {
            _showOnlyFavorites = true;
          } else {
            _showOnlyFavorites = false;
          }
        });
      },
      icon: const Icon(
        Icons.more_vert,
      ),
      itemBuilder: (ctx) => [
        const PopupMenuItem(
          value: FilterOptions.favorites,
          child: Text('Công việc yêu thích'),
        ),
        const PopupMenuItem(
          value: FilterOptions.all,
          child: Text('Tất cả công việc'),
        ),
      ],
    );
  }
}
