// import 'package:chatbot/models/user.dart';
import 'package:chatbot/ui/share/line_top.dart';
import 'package:flutter/material.dart';

class JobReceived extends StatefulWidget {
  static const routeName = '/received';

  const JobReceived({super.key});

  @override
  _JobReceivedState createState() => _JobReceivedState();
}

class _JobReceivedState extends State<JobReceived> {
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
