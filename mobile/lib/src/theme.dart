import 'package:flutter/material.dart';

const brandBlue = Color(0xFF1957D2);
const ink = Color(0xFF17223B);
const canvas = Color(0xFFF6F8FC);

ThemeData buildTheme() {
  final scheme = ColorScheme.fromSeed(seedColor: brandBlue);
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: canvas,
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontWeight: FontWeight.w800,
        color: ink,
        height: 1.15,
      ),
      titleLarge: TextStyle(fontWeight: FontWeight.w800, color: ink),
      titleMedium: TextStyle(fontWeight: FontWeight.w700, color: ink),
      bodyLarge: TextStyle(color: Color(0xFF49546A), height: 1.45),
    ),
    cardTheme: const CardThemeData(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
    ),
  );
}
