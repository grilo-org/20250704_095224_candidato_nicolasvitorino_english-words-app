import 'package:english_words_app/repositories/word_repository.dart';
import 'package:flutter/material.dart';

class WordState extends ChangeNotifier {
  final WordRepository _wordRepository;

  bool _isLoading = false;
  String _error = '';
  final List<String> _words = [];
  final List<String> _history = [];
  final List<String> _favorites = [];

  String _searchQuery = '';
  List<String> _filteredWords = [];
  bool _isSearching = false;

  WordState(this._wordRepository);

  List<String> get words => _words;
  List<String> get filteredWords => _isSearching ? _filteredWords : _words;

  bool get isLoading => _isLoading;
  String get error => _error;
  bool get isSearching => _isSearching;

  List<String> get history => _history;
  List<String> get favorites => _favorites;
  bool isFavorite(String word) => _favorites.contains(word);

  Future<void> loadInitialWords() async {
    _words.clear();
    _isLoading = true;
    notifyListeners();

    try {
      final allWords = await _wordRepository.getWords();
      _words.addAll(allWords);
      _error = '';
      _applySearch();
    } catch (e) {
      _error = 'Erro ao carregar palavras: ${e.toString()}';
    }

    _isLoading = false;
    notifyListeners();
  }

  void searchWords(String query) {
    _searchQuery = query;
    _isSearching = query.isNotEmpty;
    _applySearch();
    notifyListeners();
  }

  void _applySearch() {
    if (_isSearching) {
      _filteredWords = _words
          .where(
              (word) => word.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    } else {
      _filteredWords = [];
    }
  }

  void addToHistory(String word) {
    if (!_history.contains(word)) {
      _history.insert(0, word);
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
