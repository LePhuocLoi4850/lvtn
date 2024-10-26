import 'package:chatbot/ui/job/jobs_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'admin_product_list_tile.dart';
import '../auth/auth_manager.dart';

class UserJobsScreen extends StatefulWidget {
  static const routeName = '/user-products';
  const UserJobsScreen({Key? key}) : super(key: key);

  @override
  State<UserJobsScreen> createState() => _UserJobsScreenState();
}

class _UserJobsScreenState extends State<UserJobsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('jobs'),
        actions: <Widget>[
          // buildAddButton(context),
          buildLogoutButton(context),
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

  // Widget buildAddButton(BuildContext context) {
  //   return IconButton(
  //     onPressed: () {
  //       Navigator.of(context).pushNamed(
  //         EditJobScreen.routeName,
  //       );
  //     },
  //     icon: const Icon(Icons.add),
  //   );
  // }

  Widget buildLogoutButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<AuthManager>().logout();
        Navigator.of(context).pushReplacementNamed('/');
      },
      icon: const Icon(Icons.exit_to_app),
    );
  }
}
