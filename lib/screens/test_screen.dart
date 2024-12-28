import 'dart:math';
import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/word.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<Word> _words = [];
  Word? _currentWord;
  List<String> _options = [];
  String? _selectedAnswer;
  bool _isCorrect = false;

  @override
  void initState() {
    super.initState();
    _loadWords();
  }

  // Load words from database
  Future<void> _loadWords() async {
    final dbService = DatabaseService();
    final wordMaps = await dbService.fetchWords();
    final words = wordMaps.map((map) => Word.fromMap(map)).toList();

    if (words.isNotEmpty) {
      setState(() {
        _words = words;
        _generateQuestion();
      });
    }
  }

  // Generate question and answer options
  void _generateQuestion() {
    if (_words.isEmpty) return;

    final random = Random();
    _currentWord = _words[random.nextInt(_words.length)];

    // Generation of incorrect variants
    final incorrectAnswers = _words
        .where((word) => word.german != _currentWord!.german)
        .map((word) => word.translation)
        .toList();

    // Shuffling responses
    _options = [
      _currentWord!.translation,
      ...incorrectAnswers.take(3),
    ]..shuffle();

    _selectedAnswer = null;
    _isCorrect = false;
  }

  // Response selection processing
  void _checkAnswer(String answer) {
    setState(() {
      _selectedAnswer = answer;
      _isCorrect = answer == _currentWord!.translation;
    });
  }

  // Go to the next question
  void _nextQuestion() {
    setState(() {
      _generateQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: _currentWord == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'What is the translation of the word:',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 16),
                Text(
                  _currentWord!.german,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 32),
                ..._options.map((option) {
                  final isSelected = option == _selectedAnswer;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: _selectedAnswer == null
                          ? () => _checkAnswer(option)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected
                            ? (_isCorrect
                                ? Colors.green
                                : Colors.red)
                            : null,
                      ),
                      child: Text(option),
                    ),
                  );
                }).toList(),
                SizedBox(height: 32),
                if (_selectedAnswer != null)
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    child: Text('Next question'),
                  ),
              ],
            ),
    );
  }
}
