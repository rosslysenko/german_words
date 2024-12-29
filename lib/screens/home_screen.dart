import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lerning German')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/words'),
              child: const Text('New words'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/test'),
              child: const Text('Test'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/progress'),
              child: const Text('Progress'),
            ),
          ],
        ),
      ),
    );
  }
}
