import 'package:flutter/material.dart';

class Snackbar {
  static void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 300),
        content: Text(message),
      ),
    );
  }
}
