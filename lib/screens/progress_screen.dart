import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/word.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  int _totalWords = 0;
  int _learnedWords = 0;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  // Loading progress data from the database
  Future<void> _loadProgress() async {
    final dbService = DatabaseService();
    final wordMaps = await dbService.fetchWords();
    final words = wordMaps.map((map) => Word.fromMap(map)).toList();

    // It is "isLearned" field to store the learning status of a word.
    final learnedWords = words.where((word) => word.isLearned).length;

    setState(() {
      _totalWords = words.length;
      _learnedWords = learnedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = _totalWords > 0 ? _learnedWords / _totalWords : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your learning progress',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Text(
              'Total words: $_totalWords',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Learned: $_learnedWords',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 32),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
              minHeight: 20,
            ),
            const SizedBox(height: 16),
            Text(
              '${(progress * 100).toStringAsFixed(1)}% complete',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
