import 'package:english_words_app/router/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:english_words_app/repositories/word_repository.dart';
import 'package:english_words_app/state/word_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WordRepository wordRepository = WordRepository();
  await wordRepository.loadWordsToDatabase();

  runApp(
    ChangeNotifierProvider(
      create: (_) => WordState(wordRepository),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'English Words App',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: router,
    );
  }
}
