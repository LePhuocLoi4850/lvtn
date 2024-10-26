import 'package:flutter/material.dart';
import '/ui/admin/admin_grid_title.dart';
import '/ui/candidate/candidate_manager.dart';
import '/ui/company/company_manager.dart';
import '/ui/job/job_manager.dart';

class AdminGrid extends StatefulWidget {
  @override
  _AdminGridState createState() => _AdminGridState();
}

class _AdminGridState extends State<AdminGrid> {
  final jobManager = JobManager();
  final companyManager = CompanyManager();
  final candidateManager = CandidateManager();

  @override
  Widget build(BuildContext context) {
    final job = jobManager.allJobs;
    final company = companyManager.allCompany;
    final candidate = candidateManager.allCandidate;
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        if (index == 0) {
          return ExpansionTile(
            title: Text(
              'Danh sách công việc(${job.length})',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [SizedBox(height: 300, child: JobList())],
          );
        } else if (index == 1) {
          return ExpansionTile(
            title: Text(
              'Danh sách công ty(${company.length})',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [SizedBox(height: 300, child: CompanyList())],
          );
        } else {
          return ExpansionTile(
            title: Text(
              'Danh sách ứng viên(${candidate.length})',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [SizedBox(height: 300, child: CandidateList())],
          );
        }
      },
    );
  }
}
