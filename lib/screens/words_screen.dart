import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/word.dart';
import '../widgets/word_card.dart';

class WordsScreen extends StatefulWidget {
  const WordsScreen({super.key});

  @override
  _WordsScreenState createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> {
  List<Word> _words = [];

  @override
  void initState() {
    super.initState();
    _loadWords();
  }

  // Load words from the database
  Future<void> _loadWords() async {
    final dbService = DatabaseService();
    final wordMaps = await dbService.fetchWords();
    setState(() {
      _words = wordMaps.map((map) => Word.fromMap(map)).toList();
    });
  }

  // Widget to display a single word
  Widget _buildWordCard(Word word) {
    return WordCard(word: word);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word list'),
      ),
      body: _words.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _words.length,
              itemBuilder: (context, index) {
                return _buildWordCard(_words[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addWord(),
        child: const Icon(Icons.add),
      ),
    );
  }

  // Add a new word (for testing)
  Future<void> _addWord() async {
    final dbService = DatabaseService();
    final newWord = Word(id: 0, german: 'das Haus', translation: 'House');
    await dbService.insertWord(newWord);
    _loadWords();
  }
}
