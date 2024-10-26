import 'package:chatbot/ui/job/jobs_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../user_provider.dart';
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
    final userProvider = Provider.of<UserProvider>(context);
    final userId = userProvider.user?.userId;

    if (userId == null) {
      print(userProvider);
      return Scaffold(
        appBar: AppBar(
          title: const Text('jobs'),
        ),
        body: Center(
          child: Text('Không thể tải danh sách công việc. Vui lòng đăng nhập.'),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('jobs'),
          actions: <Widget>[
            buildLogoutButton(context),
          ],
        ),
        body: FutureBuilder(
          future: context.read<JobsManager>().fetchUserJobs(userId),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return RefreshIndicator(
              onRefresh: () =>
                  context.read<JobsManager>().fetchUserJobs(userId),
              child: buildUserJobListView(),
            );
          },
        ),
      );
    }
  }

  Widget buildUserJobListView() {
    final userProvider = Provider.of<UserProvider>(context);
    final userId = userProvider.user?.userId;

    return Consumer<JobsManager>(
      builder: (ctx, jobsManager, child) {
        final userJobs =
            jobsManager.item.where((job) => job.creatorId == userId).toList();
        userJobs.forEach((job) {
          print('Job ID: ${job.id}, Creator ID: ${job.creatorId}');
        });
        print(userJobs.length);
        return ListView.builder(
          itemCount: userJobs.length,
          itemBuilder: (ctx, i) => Column(
            children: [
              UserJobListTile(
                userJobs[i],
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

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
