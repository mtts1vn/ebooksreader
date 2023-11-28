import 'package:ebooksreader/app/model/book_model.dart';
import 'package:flutter/material.dart';

abstract class IFavorites extends ChangeNotifier {
  Future<void> addToFavorites(Book book);
  Future<void> removeFromFavorites(Book book);
  Future<bool> checkIfExistsInFavorites(Book book);
  Future<List<Book>> getAllFavorites();
}
