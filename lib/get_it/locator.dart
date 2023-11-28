import 'package:ebooksreader/app/database/database_interface.dart';
import 'package:ebooksreader/app/database/sqflite/sqflite_database_impl.dart';
import 'package:ebooksreader/app/features/favorites/favorites_interface.dart';
import 'package:ebooksreader/app/features/favorites/sqflite/sqflite_favorites_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<IDatabase>(() => SqfliteDatabaseImpl());
  getIt.registerLazySingleton<IFavorites>(() => SqfliteFavoritesImpl());
}
