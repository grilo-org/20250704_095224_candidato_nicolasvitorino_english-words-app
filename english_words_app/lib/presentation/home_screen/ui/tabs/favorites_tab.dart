import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:english_words_app/state/word_state.dart';
import 'package:english_words_app/router/routes_names.dart';
import 'package:go_router/go_router.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WordState>(
      builder: (context, state, _) {
        final favorites = state.favorites;

        if (favorites.isEmpty) {
          return const Center(
            child: Text(
              "Nenhuma palavra favorita.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 2.5,
            ),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final word = favorites[index];
              return ElevatedButton(
                onPressed: () {
                  context.pushNamed(RouteNames.wordDetail,
                      queryParams: {'word': word});
                },
                child: Text(word, textAlign: TextAlign.center),
              );
            },
          ),
        );
      },
    );
  }
}
