import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../feed/feed_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    // If _database is null, instantiate it
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'your_database_name.db');
    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  Future<void> _createTable(Database db, int version) async {
    await db.execute('''
    CREATE TABLE feeds(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      text TEXT,
      imageFilePath TEXT,
      videoFilePath TEXT,
      imageHeight REAL,
      imageWidth REAL,
      isLiked INTEGER DEFAULT 0
    )
  ''');
  }

  Future<int> insertFeed(Feed feed) async {
    Database db = await instance.database;
    return await db.insert('feeds', {
      'text': feed.text,
      'imageFilePath': feed.imageFile?.path,
      'videoFilePath': feed.videoFile?.path,
      'imageHeight': feed.imageHeight,
      'imageWidth': feed.imageWidth,
      'isLiked': feed.isLiked ? 1 : 0,
    });
  }

  Future<void> updateLikeStatus(Feed feed) async {
    if (feed.id != null) {
      Database db = await instance.database;
      await db.update(
        'feeds',
        {'isLiked': feed.isLiked ? 1 : 0},
        where: 'id = ?',
        whereArgs: [feed.id],
      );
    }
  }

  Future<List<Feed>> getAllFeeds() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('feeds');
    return List.generate(maps.length, (i) {
      return Feed.fromMap(maps[i]);
    });
  }

  Future<void> deleteFeed(Feed feed) async {
    Database db = await instance.database;
    await db.delete('feeds', where: 'id = ?', whereArgs: [feed.id]);
  }
}
