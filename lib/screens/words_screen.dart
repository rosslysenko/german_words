import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/word.dart';

class WordsScreen extends StatefulWidget {
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
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              word.german,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              word.translation,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список слов'),
      ),
      body: _words.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _words.length,
              itemBuilder: (context, index) {
                return _buildWordCard(_words[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addWord(),
        child: Icon(Icons.add),
      ),
    );
  }

  // Add a new word (for testing)
  Future<void> _addWord() async {
    final dbService = DatabaseService();
    final newWord = Word(german: 'Haus', translation: 'Дом');
    await dbService.insertWord(newWord.toMap());
    _loadWords();
  }
}
