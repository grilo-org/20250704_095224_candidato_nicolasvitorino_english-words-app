import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  _initDB() async {
    String path = join(await getDatabasesPath(), 'words.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE words(
            id TEXT PRIMARY KEY,
            word TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertWord(String word) async {
    final db = await database;
    await db.insert(
      'words',
      {'id': word, 'word': word},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<String>> getWords() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('words');

    return List.generate(maps.length, (i) {
      return maps[i]['word'] as String;
    });
  }

  Future<bool> areWordsLoaded() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('words');
    return result.isNotEmpty;
  }

  Future<void> insertWordsBulk(List<String> words) async {
    final db = await database;

    await db.transaction((txn) async {
      Batch batch = txn.batch();

      for (var word in words) {
        batch.insert(
          'words',
          {'id': word, 'word': word},
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    });
  }
}
