import 'package:english_words_app/repositories/word_repository.dart';
import 'package:flutter/material.dart';

class WordState extends ChangeNotifier {
  final WordRepository _wordRepository;

  final int _pageSize = 50;
  int _offset = 0;
  bool _hasMore = true;
  bool _isLoading = false;
  String _error = '';
  List<String> _words = [];
  List<String> _history = [];
  List<String> _favorites = [];

  WordState(this._wordRepository);

  List<String> get words => _words;
  bool get isLoading => _isLoading;
  String get error => _error;
  bool get hasMore => _hasMore;
  bool isFavorite(String word) => _favorites.contains(word);

  List<String> get history => _history;
  List<String> get favorites => _favorites;

  Future<void> loadInitialWords() async {
    _offset = 0;
    _words.clear();
    _hasMore = true;
    await fetchMoreWords();
  }

  Future<void> fetchMoreWords() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      List<String> newWords =
          await _wordRepository.getWordsPaginated(_offset, _pageSize);
      if (newWords.isEmpty) {
        _hasMore = false;
      } else {
        _offset += newWords.length;
        _words.addAll(newWords);
      }
      _error = '';
    } catch (e) {
      _error = 'Erro ao carregar palavras: ${e.toString()}';
    }

    _isLoading = false;
    notifyListeners();
  }

  void addToHistory(String word) {
    if (!_history.contains(word)) {
      _history.insert(0, word); // mais recente primeiro
      notifyListeners();
    }
  }

  void toggleFavorite(String word) {
    if (_favorites.contains(word)) {
      _favorites.remove(word);
    } else {
      _favorites.add(word);
    }
    notifyListeners();
  }
}
