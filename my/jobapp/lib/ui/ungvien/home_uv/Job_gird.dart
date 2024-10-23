import 'package:flutter/material.dart';
import 'package:jobapp/server/database.dart';

import 'job_gird_title.dart';

class JobGird extends StatefulWidget {
  const JobGird({super.key});

  @override
  State<JobGird> createState() => _JobGirdState();
}

class _JobGirdState extends State<JobGird> {
  String inter = 'Thực tập';
  List<Map<String, dynamic>> _allJobs = [];
  @override
  void initState() {
    super.initState();
    _fetchAllJobs();
  }

  void _fetchAllJobs() async {
    _allJobs = await Database().selectAllJob(false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 5, right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 10, bottom: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: Colors.orange,
                  ),
                  Text(
                    'Việc làm phù hợp',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 20, 121, 203),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: JobGirdTitle(
                  allJobs: _allJobs,
                )),
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 10, bottom: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.orange,
                  ),
                  Text(
                    'Thực tập sinh',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 20, 121, 203)),
                  ),
                ],
              ),
            ),
            Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: JobGirdTitle(
                  allJobs: _allJobs,
                )),
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 10, bottom: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.orange,
                  ),
                  Text(
                    'Việc làm Mới Nhất',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 20, 121, 203)),
                  ),
                ],
              ),
            ),
            Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: JobGirdTitle(
                  allJobs: _allJobs,
                )),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {},
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
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Ngành nghề nổi bậc',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 20, 121, 203)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(25)),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('IT CNTT'),
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(25)),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('IT CNTT'),
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(25)),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('IT CNTT'),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
