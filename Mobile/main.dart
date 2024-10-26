import 'package:flutter/material.dart';
import './ui/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tìm Việc',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Lato', cardColor: Colors.white),
      home: const JobOverviewScreen(),
      // routes: {
      //   CompanyGrid.routeName: (context) => const CompanyGrid(),
      //   CandidateGrid.routeName: (context) => const CandidateGrid(),
      // },
      // onGenerateRoute: (settings) {
      //   if (settings.name == JobDetailPage.routeName) {
      //     final jobId = settings.arguments as String;
      //     return MaterialPageRoute(builder: (ctx) {
      //       return JobDetailPage(
      //         JobManager().findById(jobId),
      //       );
      //     });
      //   }
      //   return null;
      // },
    );
  }
}
