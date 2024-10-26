import 'dart:async';
import 'package:chatbot/ui/cart/notification_manager.dart';
import 'package:chatbot/ui/share/line_top.dart';
import 'package:flutter/material.dart';
import '../cart/cart_user_screen.dart';
import '../user_provider.dart';
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

  @override
  void initState() {
    super.initState();
    _fetchJobs = context.read<JobsManager>().fetchJobs();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        title: Container(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  child: Icon(
                    Icons.account_circle,
                    size: 60,
                    color: Colors.blue[600],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    const Text(
                      'Xin chào! ',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      user?.name ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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
    return Consumer<NotificationManager>(
      builder: (context, notificationManager, child) => TopRightBadge(
        data: notificationManager.jobCount,
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
