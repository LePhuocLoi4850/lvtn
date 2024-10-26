import 'package:flutter/material.dart';
import 'edit_job_screen.dart';
import 'package:provider/provider.dart';
import 'user_job_list.dart';
import 'job_manager.dart';
import '../shared/app_drawer.dart';

class UserJobScreen extends StatelessWidget {
  static const routeName = '/user_Job';
  const UserJobScreen({super.key});
  // Future<void> _refreshJob(BuildContext context) async {
  //   await context.read<JobManager>().fetchJob(true);
  // }

  @override
  Widget build(BuildContext context) {
    final jobManager = JobManager();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Job'),
        actions: <Widget>[
          buildAddButton(context),
        ],
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _refreshJob(context),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            child: buildUserJobListView(jobManager),
            onRefresh: () => _refreshJob(context),
          );
        },
      ),
    );
  }

  Widget buildUserJobListView(JobManager jobManager) {
    return Consumer<JobManager>(
      builder: (ctx, jobManager, child) {
        return ListView.builder(
          itemCount: jobManager.itemCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              UserJobListTile(jobManager.items[i]),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditJobScreen.routeName,
        );
      },
    );
  }
}
