class WordModel {
  final String word;
  final String phonetic;
  final List<String> definitions;
  final String? audioUrl;

  WordModel({
    required this.word,
    required this.phonetic,
    required this.definitions,
    this.audioUrl,
  });

  factory WordModel.fromJson(Map<String, dynamic> json) {
    String? audio;

    if (json['phonetics'] != null) {
      for (var item in json['phonetics']) {
        if (item['audio'] != null && (item['audio'] as String).isNotEmpty) {
          audio = item['audio'];
          break;
        }
      }
    }

    final phonetic = json['phonetic'] ?? '';

    final List<String> defs = [];
    if (json['meanings'] != null) {
      for (var meaning in json['meanings']) {
        if (meaning['definitions'] != null) {
          for (var def in meaning['definitions']) {
            if (def['definition'] != null) {
              defs.add(def['definition']);
            }
          }
        }
      }
    }

    return WordModel(
      word: json['word'] ?? '',
      phonetic: phonetic,
      definitions: defs,
      audioUrl: audio,
    );
  }
}
