import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lerning German')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/words'),
              child: Text('New words'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/test'),
              child: Text('Test'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/progress'),
              child: Text('Progress'),
            ),
          ],
        ),
      ),
    );
  }
}
