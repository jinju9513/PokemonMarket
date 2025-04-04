import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// 포켓몬 테마 색상 정의
class PokemonColors {
  static const Color primaryYellow = Color(0xFFFFCB05); // 포켓몬 로고 노란색
  static const Color primaryBlue = Color(0xFF3B4CCA); // 포켓몬 로고 파란색
  static const Color primaryRed = Color(0xFFEE1515); // 포켓몬 로고 빨간색
  static const Color backgroundLight = Color(0xFFF5F5F5); // 라이트 모드 배경
  static const Color backgroundDark = Color(0xFF1A1A1A); // 다크 모드 배경
  static const Color cardLight = Colors.white; // 라이트 모드 카드 배경
  static const Color cardDark = Color(0xFF2C2C2C); // 다크 모드 카드 배경
  static const Color carrotOrange = Colors.orange; // 당근마켓 주황색
}

// 라이트 테마 정의
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: PokemonColors.primaryBlue,
  scaffoldBackgroundColor: PokemonColors.backgroundLight,
  cardColor: PokemonColors.cardLight,
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.poppins(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: GoogleFonts.poppins(
      color: Colors.black87,
      fontSize: 16,
    ),
    titleLarge: GoogleFonts.poppins(
      color: PokemonColors.primaryBlue,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: PokemonColors.primaryYellow,
      foregroundColor: PokemonColors.primaryBlue,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
    ),
  ),
  iconTheme: const IconThemeData(
    color: PokemonColors.primaryBlue,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: PokemonColors.primaryYellow,
    foregroundColor: PokemonColors.primaryBlue,
    elevation: 5,
  ),
);

// 다크 테마 정의
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: PokemonColors.primaryYellow,
  scaffoldBackgroundColor: PokemonColors.backgroundDark,
  cardColor: PokemonColors.cardDark,
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.poppins(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: GoogleFonts.poppins(
      color: Colors.white70,
      fontSize: 16,
    ),
    titleLarge: GoogleFonts.poppins(
      color: PokemonColors.primaryYellow,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: PokemonColors.primaryBlue,
      foregroundColor: PokemonColors.primaryYellow,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
    ),
  ),
  iconTheme: const IconThemeData(
    color: PokemonColors.primaryYellow,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: PokemonColors.primaryBlue,
    foregroundColor: PokemonColors.primaryYellow,
    elevation: 5,
  ),
);