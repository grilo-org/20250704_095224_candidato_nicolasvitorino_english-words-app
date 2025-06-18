import 'package:english_words_app/router/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:english_words_app/state/word_state.dart';

class WordListTab extends StatelessWidget {
  final ScrollController scrollController;

  const WordListTab({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Consumer<WordState>(
      builder: (context, state, _) {
        if (state.error.isNotEmpty) {
          return Center(child: Text(state.error));
        }

        return Column(
          children: [
            Expanded(
              child: GridView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 2.5,
                ),
                itemCount: state.words.length + (state.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < state.words.length) {
                    final word = state.words[index];
                    return ElevatedButton(
                      onPressed: () {
                        Provider.of<WordState>(context, listen: false)
                            .addToHistory(word);
                        context.pushNamed(RouteNames.wordDetail,
                            queryParams: {'word': word});
                      },
                      child: Text(word, textAlign: TextAlign.center),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
