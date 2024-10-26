import 'package:flutter/material.dart';
// import 'package:project/search/custom_search.dart';
// import './search.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.search),
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => Search()),
        //       );
        //     },
        //   ),
        // ],
        backgroundColor: Colors.white, // Màu nền của AppBar
        elevation: 0, // Độ nâng của AppBar
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: const Center(
        child: Text(
          'Home',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
