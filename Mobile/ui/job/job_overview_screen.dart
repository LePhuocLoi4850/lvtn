import 'package:flutter/material.dart';
import 'job_grid.dart';

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
      body: JobGrid(_showOnlyFavorites),
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
