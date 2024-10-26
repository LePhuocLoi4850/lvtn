import '../../models/job.dart';
import 'package:flutter/foundation.dart';
import '../../models/auth_token.dart';
import '../../services/jobs_service.dart';

class JobsManager with ChangeNotifier {
  List<Job> _items = [];

  final JobsService _jobsService;

  JobsManager([AuthToken? authToken]) : _jobsService = JobsService(authToken);

  set authToken(AuthToken? authToken) {
    _jobsService.authToken = authToken;
  }

  Future<void> fetchJobs() async {
    _items = await _jobsService.fetchJobs();
    notifyListeners();
  }

  Future<void> searchTitle({String? title}) async {
    _items = await _jobsService.searchTitle(title);
    notifyListeners();
  }

  Future<void> searchAddress({String? diachi}) async {
    _items = await _jobsService.searchAddress(diachi);
    notifyListeners();
  }

  Future<void> searchCareer({String? career}) async {
    _items = await _jobsService.searchCareer(career);
    notifyListeners();
  }

  Future<void> addJob(Job job) async {
    final newjob = await _jobsService.addJob(job);
    if (newjob != null) {
      _items.add(newjob);
      notifyListeners();
    }
  }

  int get itemCount {
    return _items.length;
  }

  List<Job> get item {
    return [..._items];
  }

  List<Job> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }

  Job? findById(String id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (error) {
      return null;
    }
  }

  Future<void> updateJob(Job job) async {
    final index = _items.indexWhere((item) => item.id == job.id);
    if (index >= 0) {
      if (await _jobsService.updateJob(job)) {
        _items[index] = job;
        notifyListeners();
      }
    }
  }

  Future<void> deleteJob(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    Job? existingjob = _items[index];
    _items.removeAt(index);
    notifyListeners();
    if (!await _jobsService.deleteJob(id)) {
      _items.insert(index, existingjob);
      notifyListeners();
    }
  }

  Future<void> toggleFavoriteStatus(Job job) async {
    final savedStatus = job.isFavorite;
    job.isFavorite = !savedStatus;

    if (!await _jobsService.saveFavoriteStatus(job)) {
      job.isFavorite = savedStatus;
    }
  }
}
