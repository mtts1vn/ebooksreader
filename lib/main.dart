import 'package:ebooksreader/app/database/database_interface.dart';
import 'package:ebooksreader/app/root.dart';
import 'package:ebooksreader/get_it/locator.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  await getIt<IDatabase>().connectDatabase();
  runApp(const BookReader());
}
