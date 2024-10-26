import 'package:flutter/material.dart';

import '../../../models/type_job.dart';

class TypeJob extends StatefulWidget {
  const TypeJob({super.key});

  @override
  State<TypeJob> createState() => _TypeJobState();
}

class _TypeJobState extends State<TypeJob> {
  final TypeJobManager _typeJobManager = TypeJobManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _typeJobManager.allTypeJob.map((TypeJob) {
            return ListTile(
              title: Text(TypeJob.name),
              onTap: () {
                setState(() {
                  _typeJobManager.selectTypeJob(TypeJob.name);
                });
              },
              tileColor: TypeJob.isSelected
                  ? Colors.blue[100]
                  : null, // Màu nền thay đổi tùy theo isSelected
            );
          }).toList(),
        ),
      ),
    );
  }
}
