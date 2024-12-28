class Word {
  final int? id;
  final String german;
  final String translation;
  final bool isLearned;

  Word({
    required this.id,
    required this.german,
    required this.translation,
    this.isLearned = false, // By default, the word is unlearned
  });

  // Convert from Map (to work with SQLite)
  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      id: map['id'],
      german: map['german'],
      translation: map['translation'],
      isLearned: map['is_learned'] == 1,
    );
  }

  // Convert to Map (for writing to SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'german': german,
      'translation': translation,
      'is_learned': isLearned ? 1 : 0,
    };
  }
}
