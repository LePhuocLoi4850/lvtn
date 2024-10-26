import 'package:myjob/models/company.dart';

import '../../models/job.dart';

class JobManager {
  final List<Job> allJobs = [
    Job(
      id: 'j001',
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
      company: Company(
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
      id: 'j002',
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
      company: Company(
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
      id: 'j003',
      title: 'Nhân Viên Tư Vấn Làm Tại VP',
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
      company: Company(
          name: 'Công ty Cổ phần dưỡng sinh công nghệ quốc tế New Sky',
          imageUrl:
              'https://tse4.mm.bing.net/th?id=OIP.9wy6MU1muEQ4DqYbnn9kowHaEK&pid=Api&P=0&h=220',
          address: '292/33/15A Bình Lợi, Phường 13, Bình Thạnh, TP HCM',
          description: 'description'),
      isFavorite: false,
    ),
    // Thêm 10 công việc nữa
    Job(
      id: 'j004',
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
      company: Company(
          name: 'Công ty cổ phần ABC Việt Nam',
          imageUrl:
              'https://tse4.mm.bing.net/th?id=OIP.9wy6MU1muEQ4DqYbnn9kowHaEK&pid=Api&P=0&h=220',
          address: '292/33/15A Bình Lợi, Phường 13, Bình Thạnh, TP HCM',
          description: 'description'),
      isFavorite: true,
    ),
    Job(
      id: 'j005',
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
      company: Company(
          name: 'CÔNG TY CỔ PHẦN CÔNG NGHỆ DỊCH VỤ SÀI GÒN',
          imageUrl:
              'https://tse4.mm.bing.net/th?id=OIP.9wy6MU1muEQ4DqYbnn9kowHaEK&pid=Api&P=0&h=220',
          address: '292/33/15A Bình Lợi, Phường 13, Bình Thạnh, TP HCM',
          description: 'description'),
      isFavorite: false,
    ),
    Job(
      id: 'j006',
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
      company: Company(
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
    return allJobs.where((alljob) => alljob.isFavorite).toList();
  }

  Job findById(String id) {
    return allJobs.firstWhere((prod) => prod.id == id);
  }
}
