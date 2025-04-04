import 'package:flutter/material.dart';
import 'package:pokemon_market/pages/home_page.dart';
import 'package:pokemon_market/theme/custom_theme.dart';
import 'package:pokemon_market/theme/theme_manager.dart';
import 'package:pokemon_market/providers/like_provider.dart';
import 'package:provider/provider.dart';

// 앱 진입점
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeManager()),
        ChangeNotifierProvider(create: (_) => LikeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

// 앱 메인 위젯
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokemon Market',
      theme: Provider.of<ThemeManager>(context).isDarkMode
          ? darkTheme
          : lightTheme,
      home: const HomePage(),
    );
  }
}
