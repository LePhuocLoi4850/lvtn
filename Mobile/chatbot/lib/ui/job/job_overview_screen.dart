import 'dart:async';
import 'package:chatbot/ui/share/line_top.dart';

import '../cart/cart_manager.dart';
import 'package:flutter/material.dart';
import '../cart/cart_screen.dart';
import 'jobs_manager.dart';
import 'package:provider/provider.dart';
import 'jobs_grid.dart';
import 'top_right_badge.dart';

class JobsOverviewScreen extends StatefulWidget {
  const JobsOverviewScreen({super.key});

  @override
  State<JobsOverviewScreen> createState() => _JobsOverviewScreenState();
}

class _JobsOverviewScreenState extends State<JobsOverviewScreen> {
  late Future<void> _fetchJobs;
  // final CartManager cartManager = CartManager();

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
        title: const Text('NewJob'),
        actions: <Widget>[
          buildRingIcon(),
        ],
        bottom: const LineTop(),
      ),
      body: CustomScrollView(
        slivers: [
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
    );
  }

  Widget buildRingIcon() {
    return Consumer<CartManager>(
      builder: (context, cartManager, child) => TopRightBadge(
        data: cartManager.jobCount,
        child: IconButton(
          icon: const Icon(
            Icons.notifications_rounded,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(CartScreen.routeName);
          },
        ),
      ),
    );
  }
}
