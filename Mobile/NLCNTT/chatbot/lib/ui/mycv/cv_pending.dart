// import 'package:chatbot/models/user.dart';
import 'package:chatbot/ui/share/line_top.dart';
import 'package:flutter/material.dart';

class JobPending extends StatefulWidget {
  static const routeName = '/Pending';

  const JobPending({super.key});

  @override
  _JobPendingState createState() => _JobPendingState();
}

class _JobPendingState extends State<JobPending> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Công việc đã nhận',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: const LineTop(),
      ),
    );
  }
}
