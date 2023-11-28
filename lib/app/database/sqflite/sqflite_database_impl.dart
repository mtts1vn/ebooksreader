import 'package:ebooksreader/app/database/database_interface.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDatabaseImpl extends IDatabase {
  late Database _connection;

  @override
  Database getConnection() {
    return _connection;
  }

  @override
  Future<void> connectDatabase() async {
    String databasePath = join(await getDatabasesPath(), "ebooksreader.db");

    _connection = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE FavoriteBooks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            author TEXT,
            coverUrl TEXT,
            downloadUrl TEXT
          )
        ''');
      },
    );
  }
}
