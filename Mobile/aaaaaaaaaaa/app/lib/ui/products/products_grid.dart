import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product_grid_title.dart';
import 'products_manager.dart';
import '../../models/job.dart';

class JobsGrid extends StatelessWidget {
  final bool showFavorites;

  const JobsGrid(this.showFavorites, {super.key});

  @override
  // Widget build(BuildContext context) {
  //   final jobs = context.select<JobsManager, List<Job>>((jobsManager) =>
  //       showFavorites ? jobsManager.favoriteItems : jobsManager.item);
  //   return GridView.builder(
  //     // physics: const NeverScrollableScrollPhysics(),
  //     padding: const EdgeInsets.all(10.0),
  //     itemCount: jobs.length,
  //     itemBuilder: (ctx, i) => JobGridTile(jobs[i]),
  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 1,
  //       childAspectRatio: 3 / 4,
  //       crossAxisSpacing: 10,
  //       mainAxisSpacing: 10,
  //     ),
  //   );
  // }
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
