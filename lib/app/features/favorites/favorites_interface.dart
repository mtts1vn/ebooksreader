import 'package:ebooksreader/app/model/book_model.dart';

abstract class IFavorites {
  Future<void> addToFavorites(Book book);
  Future<void> removeFromFavorites(Book book);
  Future<bool> checkIfExistsInFavorites(Book book);
}
