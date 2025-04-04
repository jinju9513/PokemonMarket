import 'package:flutter/material.dart';
import 'package:pokemon_market/pages/home_page.dart';
import 'package:pokemon_market/theme/custom_theme.dart';
import 'package:pokemon_market/theme/theme_manager.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeManager(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon Market',
      theme: Provider.of<ThemeManager>(context).isDarkMode ? darkTheme : lightTheme,
      home: const HomePage(),
    );
  }
}