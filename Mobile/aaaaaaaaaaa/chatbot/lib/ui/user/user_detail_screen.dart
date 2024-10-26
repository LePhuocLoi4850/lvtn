import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../models/user.dart';

class UserDetailScreen extends StatelessWidget {
  static const routeName = '/users-detail';
  const UserDetailScreen(
    this.user, {
    super.key,
  });

  final UserData user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hồ sơ cá nhân',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            CardUser(user: user),
          ],
        ),
      ),
    );
  }
}

class CardUser extends StatelessWidget {
  const CardUser({
    super.key,
    required this.user,
  });

  final UserData user;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailuserOne(user: user),
            Container(
              margin: const EdgeInsets.all(8),
              height: 1,
              width: 360,
              color: const Color.fromARGB(
                  255, 143, 143, 143), // Màu sắc của đường kẻ
            ),
            const SizedBox(height: 10),
            // Thông tin công việc
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'THÔNG TIN LIÊN HỆ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Địa chỉ: ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Text(
                            user.diachi,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      const Text(
                        'Điện thoại: ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(
                          user.phone,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      const Text(
                        'Email: ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(
                          user.email,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.all(8),
              height: 1,
              width: 360,
              color: const Color.fromARGB(
                  255, 143, 143, 143), // Màu sắc của đường kẻ
            ),
            const SizedBox(height: 10),
            //yêu cầu
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'NGHÀNH NGHỀ QUAN TÂM',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                // giới tính
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(
                          user.career,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.all(8),
                  height: 1,
                  width: 360,
                  color: const Color.fromARGB(
                      255, 143, 143, 143), // Màu sắc của đường kẻ
                ),
                const SizedBox(height: 10),
                //mô tả
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'GIỚI THIỆU BẢN THÂN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        user.describe,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 158, 155, 145)),
                        maxLines: 20, // Số dòng tối đa
                        overflow: TextOverflow
                            .ellipsis, // Tràn dòng với dấu chấm elipsis
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.all(8),
                  height: 1,
                  width: 360,
                  color: const Color.fromARGB(
                      255, 143, 143, 143), // Màu sắc của đường kẻ
                ),
                const SizedBox(height: 10),
                // yêu cầu khác
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'HỌC VẤN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Text(
                              user.gioitinh,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.all(8),
                  height: 1,
                  width: 360,
                  color: const Color.fromARGB(
                      255, 143, 143, 143), // Màu sắc của đường kẻ
                ),
                const SizedBox(height: 10),
                // phúc lợi
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'KỸ NĂNG',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Text(
                              user.phone,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DetailuserOne extends StatelessWidget {
  const DetailuserOne({
    super.key,
    required this.user,
  });

  final UserData user;
  int calculateAge(String birthDate) {
    List<String> parts = birthDate.split('/');
    DateTime birthday =
        DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthday.year;
    if (currentDate.month < birthday.month ||
        (currentDate.month == birthday.month &&
            currentDate.day < birthday.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    child: Icon(
                      Icons.account_circle,
                      size: 60,
                      color: Colors.blue[600],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                'Tuổi: ${calculateAge(user.ngaysinh)}',
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  'Giới tính: ${user.gioitinh}',
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }
}
