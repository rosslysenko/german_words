import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/word.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Database? _db;

// Method to get the database
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'words.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE words (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            german TEXT NOT NULL,
            translation TEXT NOT NULL,
            is_learned INTEGER DEFAULT 0
          )
        ''');
      },
    );
  }

 // Get all the words
  Future<List<Map<String, dynamic>>> fetchWords() async {
    final db = await database;
    return await db.query('words');
  }

  // Updates the status of the learned word
  Future<void> updateWordStatus(int id, bool isLearned) async {
    final db = await database;
    await db.update(
      'words',
      {'is_learned': isLearned ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Method for adding a word to the database
  Future<void> insertWord(Word word) async {
    final db = await database;
    await db.insert('words', word.toMap());
 }
}