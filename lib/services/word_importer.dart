import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database_service.dart';
import '../models/word.dart';

class WordImporter {
  static const _importFlagKey = 'words_imported'; // Key for the import flag

  // Checks if words have already been imported
  static Future<bool> isImportDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_importFlagKey) ?? false;
  }

  // Sets the flag indicating that the import is complete
  static Future<void> setImportDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_importFlagKey, true);
  }

  // Method to import words from the JSON file into the database
  static Future<void> importWords() async {
    final bool imported = await isImportDone();  // Check if import is already done

    if (imported) {
      print('Words have already been imported.');
      return; // If the import is already done, do nothing
    }

    // Reading data from assets/words.json
    final String response = await rootBundle.loadString('assets/words.json');
    final List<dynamic> data = jsonDecode(response);

    // Convert JSON data into a list of Word objects
    List<Word> words = data.map((item) {
      return Word(
        id: 0,  // id will be assigned automatically when inserted into the database
        german: item['german'],
        translation: item['translation'],
      );
    }).toList();

    // Inserting words into the database
    final dbService = DatabaseService();
    for (var word in words) {
      await dbService.insertWord(word);
    }

    // Mark the import as complete
    await setImportDone();

    print('Words added to database');
  }
}
