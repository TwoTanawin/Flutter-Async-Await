import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyColorChangingApp(),
    );
  }
}

class MyColorChangingApp extends StatefulWidget {
  @override
  _MyColorChangingAppState createState() => _MyColorChangingAppState();
}

class _MyColorChangingAppState extends State<MyColorChangingApp> {
  late Timer _timer;
  Color _currentColor = Colors.red;
  bool _isChangingColor = false;

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  // Start the color change by setting up a periodic timer
  Future<void> _startColorChange() async {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      _updateColor();
    });
  }

  // Stop the color change by canceling the periodic timer
  void _stopColorChange() {
    _timer.cancel();
  }

  // Update the color based on the current color value
  void _updateColor() {
    setState(() {
      _currentColor = _currentColor == Colors.red ? Colors.green : Colors.red;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Changing App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              color: _currentColor,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isChangingColor = true;
                    });
                    await _startColorChange();
                  },
                  child: Text('START'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isChangingColor = false;
                    });
                    _stopColorChange();
                  },
                  child: Text('STOP'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
