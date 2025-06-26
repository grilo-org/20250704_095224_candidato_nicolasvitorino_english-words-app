import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:english_words_app/db_helper.dart';

class WordRepository {
  final DBHelper _dbHelper = DBHelper();

  Future<void> loadWordsToDatabase() async {
    bool areWordsLoaded = await _dbHelper.areWordsLoaded();
    if (areWordsLoaded) {
      print("As palavras já foram carregadas previamente.");
      return;
    }

    print("Iniciando o carregamento do arquivo JSON...");
    String jsonString =
        await rootBundle.loadString('assets/words_dictionary.json');

    var decoded = json.decode(jsonString);
    print("Tipo real do JSON: ${decoded.runtimeType}");

    List<dynamic> rawList = json.decode(jsonString);
    List<String> words = rawList.map((e) => e.toString()).toList();
    words.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    print(
        "Arquivo JSON carregado com sucesso! Total de palavras: ${words.length}");
    print("Inserindo palavras no banco de dados em lote...");
    await _dbHelper.insertWordsBulk(words);

    print("Palavras carregadas com sucesso!");
  }

  Future<List<String>> getWords() async {
    print("Recuperando palavras do banco de dados...");
    return await _dbHelper.getWords();
  }

  Future<List<String>> getWordsPaginated() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'words',
    );
    return List.generate(maps.length, (i) => maps[i]['word'] as String);
  }
}
