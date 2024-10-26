import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/career.dart';
import 'career_grid_title.dart';
import 'job_grid_title.dart';
import 'jobs_manager.dart';
import '../../models/job.dart';

class JobsGrid extends StatelessWidget {
  final bool showFavorites;

  const JobsGrid(this.showFavorites, {super.key});

  @override
  Widget build(BuildContext context) {
    final job = context.select<JobsManager, List<Job>>((jobsManager) =>
        showFavorites ? jobsManager.favoriteItems : jobsManager.item);
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 18.0, top: 30),
          child: Text(
            'Việc làm phù hợp',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 20, 121, 203)),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: job.length,
            itemBuilder: (ctx, i) {
              return Container(
                width: 390,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 200, 200, 200)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: JobGridTile(job[i]),
              );
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 18.0, top: 30),
          child: Text(
            'Việc làm Hot',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 20, 121, 203)),
          ),
        ),
        SizedBox(
          height: 200,
          width: 400,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: job.length,
            itemBuilder: (ctx, i) {
              return Container(
                width: 380,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 200, 200, 200)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: JobGridTile(job[i]),
              );
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 18.0, top: 30),
          child: Text(
            'Việc làm mới nhất',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 20, 121, 203)),
          ),
        ),
        AllJobs(itemCount: job.length, job: job),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: SizedBox(
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/Search-job');
              },
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Colors.blue, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Xem tất cả việc làm',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 18.0, top: 20),
          child: Text(
            'Ngành nghề nổi bậc',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 20, 121, 203)),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (ctx, i) {
              Career career = CareerManager().allCareer[i];
              return Container(
                width: 200,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 255, 255, 255)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CareerGridTile(career),
              );
            },
          ),
        ),
      ],
    );
  }
}

class AllJobs extends StatelessWidget {
  const AllJobs({
    Key? key,
    required this.itemCount,
    required this.job,
  }) : super(key: key);

  final int itemCount;
  final List<Job> job;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 775,
      child: ListView.builder(
        itemCount: itemCount,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, i) {
          return Container(
            width: 380,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border:
                  Border.all(color: const Color.fromARGB(255, 200, 200, 200)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: JobGridTile(job[i]),
          );
        },
      ),
    );
  }
}
