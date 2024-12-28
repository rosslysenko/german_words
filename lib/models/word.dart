class Word {
  final int? id;
  final String german;
  final String translation;
  final bool learned;

  Word({this.id, required this.german, required this.translation, this.learned = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'german': german,
      'translation': translation,
      'learned': learned ? 1 : 0,
    };
  }

  static Word fromMap(Map<String, dynamic> map) {
    return Word(
      id: map['id'],
      german: map['german'],
      translation: map['translation'],
      learned: map['learned'] == 1,
    );
  }
}
