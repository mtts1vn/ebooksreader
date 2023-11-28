import 'package:ebooksreader/app/view/home/home_screen.dart';
import 'package:flutter/material.dart';

class BookReader extends StatelessWidget {
  const BookReader({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BookReader",
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      routes: {"/": (context) => const HomeScreen()},
      initialRoute: "/",
    );
  }
}
