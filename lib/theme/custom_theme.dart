import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.purple,
  scaffoldBackgroundColor: Colors.grey[100],
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
    ),
  ),
);
final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.purple,
  scaffoldBackgroundColor: const Color(0xFF1E1E1E),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF2D2D2D),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
    ),
  ),
  cardColor: const Color(0xFF2D2D2D),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    titleMedium: TextStyle(color: Colors.white),
  ),
  colorScheme: const ColorScheme.dark(
    primary: Colors.purple,
    secondary: Colors.purpleAccent,
    surface: Color(0xFF2D2D2D),
    onSurface: Colors.white,
  ),
);
