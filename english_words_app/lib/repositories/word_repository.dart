import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:english_words_app/db_helper.dart'; // Importando a classe DBHelper

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

    Map<String, dynamic> wordMap = json.decode(jsonString);
    List<String> words = wordMap.keys.toList();

    print("Inserindo palavras no banco de dados em lote...");
    await _dbHelper.insertWordsBulk(words);

    print("Palavras carregadas com sucesso!");
  }

  // Função para obter todas as palavras do banco de dados
  Future<List<String>> getWords() async {
    print("Recuperando palavras do banco de dados...");
    return await _dbHelper.getWords(); // Retorna todas as palavras do banco
  }

  Future<List<String>> getWordsPaginated(int offset, int limit) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'words',
      limit: limit,
      offset: offset,
    );
    return List.generate(maps.length, (i) => maps[i]['word'] as String);
  }
}
