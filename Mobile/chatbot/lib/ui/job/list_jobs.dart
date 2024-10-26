import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'job_grid_title.dart';
import 'jobs_manager.dart';
import '../../models/job.dart';

class ListJob extends StatelessWidget {
  final bool showFavorites;

  const ListJob(this.showFavorites, {super.key});

  @override
  Widget build(BuildContext context) {
    final job = context.select<JobsManager, List<Job>>((jobsManager) =>
        showFavorites ? jobsManager.favoriteItems : jobsManager.item);
    return ListView.builder(
      padding: const EdgeInsets.all(5.0),
      itemCount: job.length,
      itemExtent: 200,
      itemBuilder: (ctx, i) => Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 200, 200, 200)),
            borderRadius: BorderRadius.circular(8)),
        child: JobGridTile(job[i]),
      ),
    );
  }
}
