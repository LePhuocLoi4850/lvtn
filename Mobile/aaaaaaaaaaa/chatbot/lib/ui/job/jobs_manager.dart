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

  Future<void> fetchUserJobs(String? userId) async {
    _items = await _jobsService.fetchUserJobs(userId!);
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

  Future<void> addJob(Job job) async {
    final newjob = await _jobsService.addJob(job);
    if (newjob != null) {
      _items.addAll([newjob]);
      notifyListeners();
    }
    print(
        'Attempting to add job: $job'); // In ra thông tin về công việc đang được thêm
    try {
      // Đoạn mã thêm công việc vào cơ sở dữ liệu
      // Nếu có lỗi, sẽ được xử lý trong khối catch
      print(
          'Job added successfully: $job'); // In ra thông báo khi thêm công việc thành công
    } catch (error) {
      // Xử lý lỗi khi thêm công việc
      print(
          'Error adding job: $error'); // In ra thông báo lỗi nếu có lỗi xảy ra
      throw error; // Ném lỗi để xử lý ở nơi gọi phương thức addJob
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
