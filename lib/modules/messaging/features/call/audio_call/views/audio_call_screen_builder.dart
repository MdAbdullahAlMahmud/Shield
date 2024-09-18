import 'package:flutter/material.dart';

class AudioCallScreenBuilder extends StatelessWidget {
  final dynamic data;
  const AudioCallScreenBuilder({super.key, this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.phone_in_talk, color: Colors.white, size: 100),
            SizedBox(height: 20),
            Text('Audio Call', style: TextStyle(color: Colors.white, fontSize: 24)),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(24),
                backgroundColor: Colors.red,
              ),
              child: Icon(Icons.call_end, color: Colors.white, size: 36),
            ),
          ],
        ),
      ),
    );
  }
}
