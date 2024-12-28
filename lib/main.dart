import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/words_screen.dart';
import 'screens/test_screen.dart';
import 'screens/progress_screen.dart';
import 'services/word_importer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WordImporter.importWords();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn German Words',
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
