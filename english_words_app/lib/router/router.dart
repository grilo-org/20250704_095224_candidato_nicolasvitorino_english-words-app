import 'package:english_words_app/features/home_screen/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:english_words_app/features/word_detail/ui/word_detail_screen.dart';
import 'package:english_words_app/router/routes_names.dart';

final GoRouter _router = GoRouter(
  initialLocation: RouteNames.wordList,
  routes: [
    GoRoute(
      path: RouteNames.wordList,
      name: 'wordList',
      builder: (context, state) =>
          HomeScreen(), // <-- AQUI: HomeScreen via rota
    ),
    GoRoute(
      path: RouteNames.wordDetail,
      name: RouteNames.wordDetail,
      builder: (context, state) {
        final word = state.queryParams['word'] ?? '';
        return WordDetailScreen(word: word);
      },
    ),
  ],
);

GoRouter get router => _router;
