// import 'package:chatbot/models/user.dart';
import 'package:chatbot/ui/share/line_top.dart';
import 'package:flutter/material.dart';

class JobDenied extends StatefulWidget {
  static const routeName = '/Denied';

  const JobDenied({super.key});

  @override
  _JobDeniedState createState() => _JobDeniedState();
}

class _JobDeniedState extends State<JobDenied> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Công việc bị từ chối',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: const LineTop(),
      ),
    );
  }
}
