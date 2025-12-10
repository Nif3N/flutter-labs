class DictionaryEntry {
  final String word;
  final List<Meaning> meanings;

  DictionaryEntry({
    required this.word,
    required this.meanings,
  });

  factory DictionaryEntry.fromJson(Map<String, dynamic> json) {
    final meanings = (json['meanings'] as List?)
        ?.map((e) => Meaning.fromJson(e as Map<String, dynamic>))
        .toList() ??
        [];

    return DictionaryEntry(
      word: json['word'] ?? 'unknown',
      meanings: meanings,
    );
  }
}

class Meaning {
  final String partOfSpeech;
  final List<Definition> definitions;

  Meaning({
    required this.partOfSpeech,
    required this.definitions,
  });

  factory Meaning.fromJson(Map<String, dynamic> json) {
    final definitions = (json['definitions'] as List?)
        ?.map((e) => Definition.fromJson(e as Map<String, dynamic>))
        .toList() ??
        [];

    return Meaning(
      partOfSpeech: json['partOfSpeech'] ?? 'unknown',
      definitions: definitions,
    );
  }
}

class Definition {
  final String definition;
  final String? example;

  Definition({
    required this.definition,
    this.example,
  });

  factory Definition.fromJson(Map<String, dynamic> json) {
    return Definition(
      definition: json['definition'] ?? 'No definition',
      example: json['example'] as String?,
    );
  }
}