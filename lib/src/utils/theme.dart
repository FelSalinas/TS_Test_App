import 'package:flutter/material.dart';

class AppTheme {
  final ThemeData custom = ThemeData.light().copyWith(
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: Colors.black),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    ),
  );
}
