import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  Database? _database;

  DatabaseService._internal();

  factory DatabaseService() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'words.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE words(id INTEGER PRIMARY KEY, german TEXT, translation TEXT, learned INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertWord(Map<String, dynamic> word) async {
    final db = await database;
    await db.insert('words', word, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> fetchWords() async {
    final db = await database;
    return db.query('words');
  }
}
