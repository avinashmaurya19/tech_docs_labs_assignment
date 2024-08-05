import 'package:flutter/material.dart';

class AppThemes {
  static final lightMode = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.green,
    brightness: Brightness.light,
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.green, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      hintStyle: const TextStyle(color: Colors.grey),
      fillColor: Colors.white,
    ),
  );
  static final darkMode = ThemeData(
    scaffoldBackgroundColor: const Color(0xff1f1f21),
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.green, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      hintStyle: const TextStyle(color: Colors.grey),
      fillColor: const Color(0xff1f1f21),
    ),
  );
}
