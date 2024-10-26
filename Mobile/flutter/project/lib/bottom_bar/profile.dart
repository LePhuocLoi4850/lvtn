import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('thông tin cá nhân'),
      ),
      body: Center(
        child: Text(
          'thông tin',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
