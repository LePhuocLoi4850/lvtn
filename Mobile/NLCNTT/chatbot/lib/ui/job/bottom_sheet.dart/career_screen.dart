import 'package:flutter/material.dart';

import '../../../models/career.dart';

class ListCareer extends StatefulWidget {
  const ListCareer({super.key});

  @override
  State<ListCareer> createState() => _ListCareerState();
}

class _ListCareerState extends State<ListCareer> {
  final CareerManager _careerManager = CareerManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _careerManager.allCareer.map((career) {
            return ListTile(
              title: Text(career.name),
              onTap: () {
                setState(() {
                  _careerManager.selectCareer(career.name);
                });
              },
              tileColor: career.isSelected
                  ? Colors.blue[100]
                  : null, // Màu nền thay đổi tùy theo isSelected
            );
          }).toList(),
        ),
      ),
    );
  }
}
