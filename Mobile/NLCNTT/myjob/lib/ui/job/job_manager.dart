import 'package:flutter/foundation.dart';

import '../../models/auth_token.dart';
import '../../models/company.dart';
import '../../models/job.dart';
// import '../../services/job_service.dart';

class JobManager with ChangeNotifier {
  List<Job> allJobs = [
    Job(
      title: 'Nhân Viên Telesale, Không Yêu Cầu Kinh Nghiệm',
      imageUrl:
          'https://tse4.mm.bing.net/th?id=OIP.tUVlmB4TJu38NOzw6VgU5gHaJl&pid=Api&P=0&h=220',
      luong: '9 000 000 đến 11 000 000',
      loai: 'Full-time',
      soluong: '5',
      lich: 'T2-T6',
      gioitinh: 'Nam',
      tuoi: '20-30',
      hocvan: 'Đại học',
      kinhnghiem: '1 năm',
      description: 'GOOD JOB',
      company: const Company(
        description: 'good',
        name: 'Công ty Cổ phần Airtech Thế Long',
        imageUrl:
            'https://tse4.mm.bing.net/th?id=OIP.9wy6MU1muEQ4DqYbnn9kowHaEK&pid=Api&P=0&h=220',
        address: 'Đường 3/2, Xuân Khánh, Ninh Kiều, Cần Thơ',
      ),
      yeucaukhac: 'Yêu cầu khác cho công việc 1',
      phucloi: 'Phúc lợi cho công việc 1',
      isFavorite: true,
    ),
    Job(
      title: 'Nhân Viên Telesale',
      imageUrl:
          'https://tse4.mm.bing.net/th?id=OIP.tUVlmB4TJu38NOzw6VgU5gHaJl&pid=Api&P=0&h=220',
      luong: '7 000 000 đến 8 000 000',
      loai: 'Full-time',
      soluong: '5',
      lich: 'T2-T6',
      gioitinh: 'Nam',
      tuoi: '20-30',
      hocvan: 'Đại học',
      kinhnghiem: '1 năm',
      description: 'GOOD JOB',
      company: const Company(
        description: 'good',
        name: 'Công ty Cổ phần Airtech Thế Long',
        imageUrl:
            'https://tse4.mm.bing.net/th?id=OIP.9wy6MU1muEQ4DqYbnn9kowHaEK&pid=Api&P=0&h=220',
        address: 'Đường 3/2, Xuân Khánh, Ninh Kiều, Cần Thơ',
      ),
      yeucaukhac: 'Yêu cầu khác cho công việc 1',
      phucloi: 'Phúc lợi cho công việc 1',
      isFavorite: true,
    ),
    Job(
      title: 'Nhân Viên Tư Vấn Làm Tại VP - Không Yêu Cầu Kinh Nghiệm',
      imageUrl:
          'https://tse4.mm.bing.net/th?id=OIP.tUVlmB4TJu38NOzw6VgU5gHaJl&pid=Api&P=0&h=220',
      luong: '7 000 000 đến 10 000 000',
      loai: 'Part-time',
      soluong: '3',
      lich: 'T2-T6',
      gioitinh: 'Nữ',
      tuoi: '18-25',
      hocvan: 'Cao đẳng',
      kinhnghiem: 'Không yêu cầu',
      description: 'GOOD JOB',
      yeucaukhac: 'Yêu cầu khác cho công việc 2',
      phucloi: 'Phúc lợi cho công việc 2',
      company: const Company(
          name: 'Công ty Cổ phần dưỡng sinh công nghệ quốc tế New Sky',
          imageUrl:
              'https://tse4.mm.bing.net/th?id=OIP.9wy6MU1muEQ4DqYbnn9kowHaEK&pid=Api&P=0&h=220',
          address: '292/33/15A Bình Lợi, Phường 13, Bình Thạnh, TP HCM',
          description: 'description'),
      isFavorite: false,
    ),
    // Thêm 10 công việc nữa
    Job(
      title: 'Nhân Viên Kinh Doanh',
      imageUrl:
          'https://tse4.mm.bing.net/th?id=OIP.tUVlmB4TJu38NOzw6VgU5gHaJl&pid=Api&P=0&h=220',
      luong: '10 000 000 đến 15 000 000',
      loai: 'Full-time',
      soluong: '7',
      lich: 'T2-T7',
      gioitinh: 'Nữ',
      tuoi: '22-35',
      hocvan: 'Cao đẳng trở lên',
      kinhnghiem: '2 năm',
      description: 'GOOD JOB',
      yeucaukhac: 'Yêu cầu khác cho công việc 3',
      phucloi: 'Phúc lợi cho công việc 3',
      company: const Company(
          name: 'Công ty cổ phần ABC Việt Nam',
          imageUrl:
              'https://tse4.mm.bing.net/th?id=OIP.9wy6MU1muEQ4DqYbnn9kowHaEK&pid=Api&P=0&h=220',
          address: '292/33/15A Bình Lợi, Phường 13, Bình Thạnh, TP HCM',
          description: 'description'),
      isFavorite: true,
    ),
    Job(
      title: 'Cộng Tác Viên Mảng Tin Tức Tiếng Anh',
      imageUrl:
          'https://tse4.mm.bing.net/th?id=OIP.tUVlmB4TJu38NOzw6VgU5gHaJl&pid=Api&P=0&h=220',
      luong: '5 000 000 đến 7 000 000',
      loai: 'Full-time',
      soluong: '10',
      lich: 'T3-T7',
      gioitinh: 'Nữ',
      tuoi: '20-28',
      hocvan: 'Đại học',
      kinhnghiem: '1 năm',
      description: 'GOOD JOB',
      yeucaukhac: 'Yêu cầu khác cho công việc 4',
      phucloi: 'Phúc lợi cho công việc 4',
      company: const Company(
          name: 'CÔNG TY CỔ PHẦN CÔNG NGHỆ DỊCH VỤ SÀI GÒN',
          imageUrl:
              'https://tse4.mm.bing.net/th?id=OIP.9wy6MU1muEQ4DqYbnn9kowHaEK&pid=Api&P=0&h=220',
          address: '292/33/15A Bình Lợi, Phường 13, Bình Thạnh, TP HCM',
          description: 'description'),
      isFavorite: false,
    ),
    Job(
      title: 'CTV Quản Trị Page Mảng Tin Tức',
      imageUrl:
          'https://tse4.mm.bing.net/th?id=OIP.tUVlmB4TJu38NOzw6VgU5gHaJl&pid=Api&P=0&h=220',
      luong: '8 000 000 đến 10 000 000',
      loai: 'Part-time',
      soluong: '5',
      lich: 'T2-T6',
      gioitinh: 'Nữ',
      tuoi: '18-30',
      hocvan: 'Trung cấp',
      kinhnghiem: 'Không yêu cầu',
      description: 'Mô tả công việc 5',
      yeucaukhac: 'Yêu cầu khác cho công việc 5',
      phucloi: 'Phúc lợi cho công việc 5',
      company: const Company(
          name: 'Công ty Cổ phần dưỡng sinh công nghệ quốc tế New Sky',
          imageUrl:
              'https://tse4.mm.bing.net/th?id=OIP.9wy6MU1muEQ4DqYbnn9kowHaEK&pid=Api&P=0&h=220',
          address: '292/33/15A Bình Lợi, Phường 13, Bình Thạnh, TP HCM',
          description: 'description'),
      isFavorite: false,
    ),
  ];
  int get itemCount {
    return allJobs.length;
  }

  List<Job> get items {
    return [...allJobs];
  }

  List<Job> get favoritesAlljobs {
    return allJobs.where((item) => item.isFavorite).toList();
  }

  set authToken(AuthToken? authToken) {}

  Job findById(String id) {
    return allJobs.firstWhere((prod) => prod.id == id);
  }

  void addJob(Job job) {
    allJobs.add(
      job.copyWith(
        id: 'p${DateTime.now().toIso8601String}',
      ),
    );
    notifyListeners();
  }

  void updateJob(Job job) {
    final index = allJobs.indexWhere((item) => item.id == job.id);
    if (index >= 0) {
      allJobs[index] = job;
      notifyListeners();
    }
  }

  void toggleFavorites(Job job) {
    final savedStatus = job.isFavorite;
    job.isFavorite = !savedStatus;
  }

  void deleteJob(String id) {
    final index = allJobs.indexWhere((item) => item.id == id);
    allJobs.removeAt(index);
    notifyListeners();
  }
  // final JobService _jobService;

  // JobManager([AuthToken? authToken]) : _jobService = JobService(authToken);

  // set authToken(AuthToken? authToken) {
  //   _jobService.authToken = authToken;
  // }

  // Future<void> fetchJob([bool filterByUser = false]) async {
  //   allJobs = await _jobService.fetchJob(filterByUser);
  //   notifyListeners();
  // }

  // Future<void> addJob(Job job) async {
  //   final newJob = await _jobService.addJob(job);
  //   if (newJob != null) {
  //     allJobs.add(newJob);
  //     notifyListeners();
  //   }
  // }

  // int get itemCount {
  //   return allJobs.length;
  // }

  // List<Job> get items {
  //   return [...allJobs];
  // }

  // List<Job> get favoritesAlljobs {
  //   return allJobs.where((alljob) => alljob.isFavorite).toList();
  // }

  // Job findById(String id) {
  //   return allJobs.firstWhere((prod) => prod.id == id);
  // }

  // void updateJob(Job job) {
  //   final index = allJobs.indexWhere((item) => item.id == job.id);
  //   if (index >= 0) {
  //     allJobs[index] = job;
  //     notifyListeners();
  //   }
  // }

  // void toggleFavorites(Job job) {
  //   final savedStatus = job.isFavorite;
  //   job.isFavorite = !savedStatus;
  // }

  // void deletejob(String id) {
  //   final index = allJobs.indexWhere((item) => item.id == id);
  //   allJobs.removeAt(index);
  //   notifyListeners();
  // }
}
