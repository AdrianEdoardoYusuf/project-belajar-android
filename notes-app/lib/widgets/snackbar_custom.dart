import 'package:flutter/material.dart';
import 'package:notes_app_sqflite/main.dart';

class SnacbarCustom {
  static snackbarSucces({required String message}) {
    ScaffoldMessenger.of(navigationKey.currentContext!).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      backgroundColor: Colors.green,
    ));
  }

  static snackbarError({required String message}) {
    ScaffoldMessenger.of(navigationKey.currentContext!).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }
}
