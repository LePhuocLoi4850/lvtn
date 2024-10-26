import 'package:flutter/material.dart';
import '../screens.dart';
import 'package:provider/provider.dart';
import '../../models/job.dart';
import '../job/jobs_manager.dart';
import './edit_product_screen.dart';

class UserJobListTile extends StatelessWidget {
  final Job job;
  const UserJobListTile(
    this.job, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(job.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(job.imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            buildEditButton(context),
            buildDeleteButton(context),
          ],
        ),
      ),
    );
  }

  Widget buildDeleteButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        context.read<JobsManager>().deleteJob(job.id!);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text(
                'job delete',
                textAlign: TextAlign.center,
              ),
            ),
          );
      },
      color: Theme.of(context).colorScheme.error,
    );
  }

  Widget buildEditButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditJobScreen.routeName,
          arguments: job.id,
        );
      },
      color: Theme.of(context).primaryColor,
    );
  }
}
