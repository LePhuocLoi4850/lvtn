import 'package:flutter/material.dart';
import '../models/job.dart';

class JobProvider extends ChangeNotifier {
  final List<Job> _appliedJobs = [];

  List<Job> get appliedJobs => _appliedJobs;

  void addAppliedJob(Job job) {
    _appliedJobs.add(job);
    notifyListeners();
  }

  void removeAppliedJob(Job job) {
    _appliedJobs.remove(job);
    notifyListeners();
  }

  bool isJobApplied(Job job) {
    return _appliedJobs.contains(job);
  }

  void toggleApplied(Job job) {
    if (_appliedJobs.contains(job)) {
      _appliedJobs.remove(job);
    } else {
      _appliedJobs.add(job);
    }
    notifyListeners();
  }
}
