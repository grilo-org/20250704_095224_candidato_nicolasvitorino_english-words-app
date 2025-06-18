import 'dart:convert';
import 'package:english_words_app/models/word_model.dart';
import 'package:http/http.dart' as http;

class DictionaryRepository {
  Future<WordModel?> fetchWordDetail(String word) async {
    final url =
        Uri.parse("https://api.dictionaryapi.dev/api/v2/entries/en/$word");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return WordModel.fromJson(jsonResponse.first);
    } else {
      return null;
    }
  }
}
