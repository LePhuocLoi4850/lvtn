import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NumberFormatDemo extends StatefulWidget {
  @override
  _NumberFormatDemoState createState() => _NumberFormatDemoState();
}

class _NumberFormatDemoState extends State<NumberFormatDemo> {
  double _number = 0;

  @override
  Widget build(BuildContext context) {
    // Định dạng số
    NumberFormat numberFormat = NumberFormat("#,##0.###");

    return Scaffold(
      appBar: AppBar(
        title: Text('Number Format Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter a number:',
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _number = double.tryParse(value) ?? 0;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Formatted number:',
            ),
            Text(
              numberFormat.format(_number),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
