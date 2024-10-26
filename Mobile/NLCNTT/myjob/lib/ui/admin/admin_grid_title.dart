import 'package:flutter/material.dart';
import 'package:myjob/models/candidate.dart';
import 'package:myjob/models/company.dart';
import 'package:myjob/models/job.dart';
import 'package:myjob/ui/candidate/candidate_manager.dart';
import 'package:myjob/ui/company/company_manager.dart';
import 'package:myjob/ui/job/job_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class JobList extends StatelessWidget {
  final JobManager jobManager = JobManager();

  JobList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Job> jobList = jobManager.allJobs;

    return ListView.builder(
      itemCount: jobList.length,
      itemBuilder: (context, index) {
        Color? backgroundColor =
            index % 2 == 0 ? Colors.grey[200] : Colors.white;
        final job = jobList[index];
        return Container(
          height: 60,
          child: Card(
            color: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(0), // Đặt borderRadius thành 0
            ),
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      job.title,
                      style: TextStyle(fontSize: 15),
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis, // Đặt overflow thành ellipsis
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    print('delete item');
                  },
                  icon: const FaIcon(FontAwesomeIcons.trashCan),
                  color: Colors.red,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CompanyList extends StatelessWidget {
  final CompanyManager companyManager = CompanyManager();

  CompanyList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Company> companyList = companyManager.allCompany;

    return ListView.builder(
      itemCount: companyList.length,
      itemBuilder: (context, index) {
        Color? backgroundColor =
            index % 2 == 0 ? Colors.grey[200] : Colors.white;
        final company = companyList[index];
        return Container(
          height: 60,
          child: Card(
            color: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(0), // Đặt borderRadius thành 0
            ),
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      company.name,
                      style: TextStyle(fontSize: 15),
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis, // Đặt overflow thành ellipsis
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    print('delete item');
                  },
                  icon: const FaIcon(FontAwesomeIcons.trashCan),
                  color: Colors.red,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CandidateList extends StatelessWidget {
  final CandidateManager candidateManager = CandidateManager();

  CandidateList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Candidate> candidateList = candidateManager.allCandidate;

    return ListView.builder(
      itemCount: candidateList.length,
      itemBuilder: (context, index) {
        Color? backgroundColor =
            index % 2 == 0 ? Colors.grey[200] : Colors.white;
        final candidate = candidateList[index];
        return Container(
          height: 60,
          child: Card(
            color: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(0), // Đặt borderRadius thành 0
            ),
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      candidate.name,
                      style: TextStyle(fontSize: 15),
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis, // Đặt overflow thành ellipsis
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    print('delete item');
                  },
                  icon: const FaIcon(FontAwesomeIcons.trashCan),
                  color: Colors.red,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
