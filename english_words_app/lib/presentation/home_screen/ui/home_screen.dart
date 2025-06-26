import 'package:english_words_app/presentation/home_screen/ui/tabs/favorites_tab.dart';
import 'package:english_words_app/presentation/home_screen/ui/tabs/history_tab.dart';
import 'package:english_words_app/presentation/home_screen/ui/tabs/word_list_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:english_words_app/state/word_state.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    final provider = Provider.of<WordState>(context, listen: false);
    provider.loadInitialWords();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('English Words'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Word List'),
              Tab(text: 'History'),
              Tab(text: 'Favorites'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            WordListTab(),
            HistoryTab(),
            FavoritesTab(),
          ],
        ),
      ),
    );
  }
}
