import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../domain/post.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('posts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE posts(
      id INTEGER PRIMARY KEY,
      userId INTEGER,
      title TEXT,
      body TEXT
    )
    ''');
  }

  Future<void> insertPosts(List<Post> posts) async {
    final db = await database;
    await db.transaction((txn) async {
      for (var post in posts) {
        await txn.insert('posts', post.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }

  Future<List<Post>> getPosts() async {
    final db = await database;
    final maps = await db.query('posts');
    return List.generate(maps.length, (i) => Post.fromJson(maps[i]));
  }

  Future<void> deleteAllPosts() async {
    final db = await database;
    await db.delete('posts');
  }
}
