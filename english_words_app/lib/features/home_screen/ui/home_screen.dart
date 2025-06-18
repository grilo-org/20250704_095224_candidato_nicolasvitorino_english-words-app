import 'package:english_words_app/features/home_screen/ui/tabs/favorites_tab.dart';
import 'package:english_words_app/features/home_screen/ui/tabs/history_tab.dart';
import 'package:english_words_app/features/home_screen/ui/tabs/word_list_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:english_words_app/state/word_state.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    final provider = Provider.of<WordState>(context, listen: false);
    provider.loadInitialWords();

    _scrollController.addListener(() {
      final state = Provider.of<WordState>(context, listen: false);
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !state.isLoading &&
          state.hasMore) {
        state.fetchMoreWords();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('English Words'),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Word List'),
              Tab(text: 'History'),
              Tab(text: 'Favorites'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            WordListTab(scrollController: _scrollController),
            HistoryTab(),
            const FavoritesTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderTab(String title) {
    return Center(
      child: Text(
        '$title ainda não implementado',
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }
}
