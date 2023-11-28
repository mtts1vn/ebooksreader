import 'package:ebooksreader/app/database/database_interface.dart';
import 'package:ebooksreader/app/features/favorites/favorites_interface.dart';
import 'package:ebooksreader/app/model/book_model.dart';
import 'package:ebooksreader/get_it/locator.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteFavoritesImpl implements IFavorites {
  Database database = getIt<IDatabase>().getConnection();

  @override
  Future<void> addToFavorites(Book book) async {
    await database.insert(
      'FavoriteBooks',
      {
        'id': book.id,
        'title': book.title,
        'author': book.author,
        'coverUrl': book.coverUrl,
        'downloadUrl': book.downloadUrl,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  @override
  Future<bool> checkIfExistsInFavorites(Book book) async {
    final List<Map<String, dynamic>> result = await database.query(
      'FavoriteBooks',
      where: 'title = ? AND author = ?',
      whereArgs: [book.title, book.author],
    );
    return result.isNotEmpty;
  }

  @override
  Future<void> removeFromFavorites(Book book) async {
    await database.delete(
      'FavoriteBooks',
      where: 'title = ? AND author = ?',
      whereArgs: [book.title, book.author],
    );
  }
}
