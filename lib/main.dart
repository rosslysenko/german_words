import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/words_screen.dart';
import 'screens/test_screen.dart';
import 'screens/progress_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'German Words',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/words': (context) => WordsScreen(),
        '/test': (context) => TestScreen(),
        '/progress': (context) => ProgressScreen(),
      },
    );
  }
}
