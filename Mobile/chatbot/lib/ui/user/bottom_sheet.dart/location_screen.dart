import 'package:flutter/material.dart';

import '../../../models/location.dart';

class ListLocation extends StatefulWidget {
  const ListLocation({super.key});

  @override
  State<ListLocation> createState() => _ListLocationState();
}

class _ListLocationState extends State<ListLocation> {
  final LocationManager _locationManager = LocationManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _locationManager.allLocation.map((location) {
            return ListTile(
              title: Text(location.name),
              onTap: () {
                setState(() {
                  _locationManager.selectLocation(location.name);
                });
              },
              tileColor: location.isSelected
                  ? Colors.blue[100]
                  : null, // Màu nền thay đổi tùy theo isSelected
            );
          }).toList(),
        ),
      ),
    );
  }
}
