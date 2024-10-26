import 'package:flutter/material.dart';

import 'job_grid_tile.dart';
import 'job_manager.dart';

class JobGrid extends StatelessWidget {
  final bool showFavorites;

  const JobGrid(this.showFavorites, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final jobManager = JobManager();
    final job =
        showFavorites ? jobManager.favoritesAlljobs : jobManager.allJobs;
    return ListView.builder(
      padding: const EdgeInsets.all(5.0),
      itemCount: job.length,
      itemExtent: 200,
      itemBuilder: (ctx, i) => Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 200, 200, 200)),
            borderRadius: BorderRadius.circular(8)),
        child: JobGirdTile(job[i]),
      ),
    );
  }
}
