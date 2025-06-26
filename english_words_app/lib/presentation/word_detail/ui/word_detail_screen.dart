import 'package:english_words_app/models/word_model.dart';
import 'package:english_words_app/state/word_state.dart';
import 'package:flutter/material.dart';
import 'package:english_words_app/repositories/dictionary_repository.dart';
import 'package:provider/provider.dart';
import 'package:just_audio/just_audio.dart';

class WordDetailScreen extends StatefulWidget {
  final String word;

  const WordDetailScreen({super.key, required this.word});

  @override
  State<WordDetailScreen> createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen> {
  late Future<WordModel?> _futureDetail;
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _futureDetail = DictionaryRepository().fetchWordDetail(widget.word);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _playAudio(String url) async {
    try {
      final formattedUrl = url.startsWith('http') ? url : 'https:$url';
      await _player.setUrl(formattedUrl);
      _player.play();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error when playing audio')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Details'),
        leading: const BackButton(),
        actions: [
          Consumer<WordState>(
            builder: (context, state, _) {
              final isFav = state.isFavorite(widget.word);
              return IconButton(
                icon: Icon(isFav ? Icons.star : Icons.star_border),
                onPressed: () {
                  state.toggleFavorite(widget.word);
                },
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<WordModel?>(
        future: _futureDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text(
                'Word not found 😕',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          final wordData = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    wordData.word,
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
                if (wordData.phonetic.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      wordData.phonetic,
                      style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                if (wordData.audioUrl != null) ...[
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () => _playAudio(wordData.audioUrl!),
                      icon: Icon(Icons.volume_up),
                      label: Text('Play Pronunciation'),
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                const Text("Meanings:",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    itemCount: wordData.definitions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text("• ${wordData.definitions[index]}",
                            style: const TextStyle(fontSize: 16)),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
