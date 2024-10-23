import 'package:demo/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          // Lắng nghe sự thay đổi của userModel và cập nhật giao diện
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${userController.userModel.value.name}',
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Email: ${userController.userModel.value.email}',
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Age: ${userController.userModel.value.age}',
                  style: TextStyle(fontSize: 18)),
            ],
          );
        }),
      ),
    );
  }
}
