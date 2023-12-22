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
    if (_database != null) return _database!; // If _database is null, instantiate it
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'good_hearts_database.db');
    return await openDatabase(path, version: 2, onCreate: _createTables, onUpgrade: _upgradeTables);
  }

  Future<void> _upgradeTables(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add any migration steps for version 2 and above
      await db.execute('''
      CREATE TABLE comments(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        postId INTEGER,
        userId INTEGER,
        textContent TEXT,
        time TEXT
      )
    ''');
    }
  }


  Future<void> _createTables(Database db, int version) async {
    // Create User table
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        profilePicturePath TEXT,
        settings TEXT
      )
    ''');

    // Create PostCache table
    await db.execute('''
      CREATE TABLE post_caches(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        postId INTEGER,
        textContent TEXT,
        mediaPath TEXT,
        time TEXT,
        likeCount INTEGER DEFAULT 0,
        commentCount INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
    CREATE TABLE comments(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      postId INTEGER,
      userId INTEGER,
      textContent TEXT,
      time TEXT
    )
  ''');
  }

  Future<int> insertUser(User user) async {
    Database db = await instance.database;
    return await db.insert('users', {
      'username': user.username,
      'profilePicturePath': user.profilePicturePath,
      'settings': user.settings,
    });
  }

  Future<int> insertPostCache(PostCache postCache) async {
    Database db = await instance.database;
    return await db.insert('post_caches', {
      'postId': postCache.postId,
      'textContent': postCache.textContent,
      'mediaPath': postCache.mediaPath,
      'time': postCache.time,
      'likeCount': postCache.likeCount,
      'commentCount': postCache.commentCount,
    });
  }

  Future<int> insertComment(Comment comment) async {
    Database db = await instance.database;
    return await db.insert('comments', {
      'postId': comment.postId,
      'userId': comment.userId,
      'textContent': comment.textContent,
      'time': comment.time,
    });
  }


  Future<List<PostCache>> getAllPostCaches() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('post_caches');
    return List.generate(maps.length, (i) {
      return PostCache.fromMap(maps[i]);
    });
  }

  Future<List<Comment>> getCommentsForPost(int postId) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      'comments',
      where: 'postId = ?',
      whereArgs: [postId],
    );
    return List.generate(maps.length, (i) {
      return Comment.fromMap(maps[i]);
    });
  }

  Future<void> updatePostCacheLikeStatus(PostCache postCache) async {
    if (postCache.id != null) {
      Database db = await instance.database;
      await db.update(
        'post_caches',
        {'likeCount': postCache.likeCount},
        where: 'id = ?',
        whereArgs: [postCache.id],
      );
    }
  }


  Future<void> deletePostCache(PostCache postCache) async {
    if (postCache.id != null) {
      Database db = await instance.database;
      await db.delete('post_caches', where: 'id = ?', whereArgs: [postCache.id]);
    }
  }



// You can add methods for fetching data from the new tables as needed.
}
