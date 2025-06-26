import 'package:english_words_app/presentation/home_screen/ui/features/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:english_words_app/state/word_state.dart';
import 'package:english_words_app/router/routes_names.dart';

class WordListTab extends StatelessWidget {
  const WordListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBarWidget(
          onChanged: (query) {
            Provider.of<WordState>(context, listen: false).searchWords(query);
          },
        ),
        Expanded(
          child: Consumer<WordState>(
            builder: (context, state, _) {
              if (state.error.isNotEmpty) {
                return Center(child: Text(state.error));
              }

              final words = state.filteredWords;

              if (words.isEmpty && !state.isLoading) {
                return const Center(child: Text("Nenhuma palavra encontrada."));
              }

              return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 2.5,
                ),
                itemCount: words.length,
                itemBuilder: (context, index) {
                  final word = words[index];
                  return ElevatedButton(
                    onPressed: () {
                      Provider.of<WordState>(context, listen: false)
                          .addToHistory(word);
                      context.pushNamed(
                        RouteNames.wordDetail,
                        queryParams: {'word': word},
                      );
                    },
                    child: Text(word, textAlign: TextAlign.center),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
