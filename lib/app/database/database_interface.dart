import 'package:sqflite/sqflite.dart';

abstract class IDatabase {
  Future<void> connectDatabase();
  Database getConnection();
}
