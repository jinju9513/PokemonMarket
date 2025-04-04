import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokemon_market/pages/home_page.dart';
import 'package:pokemon_market/theme/custom_theme.dart';
import 'package:pokemon_market/theme/theme_manager.dart';
import 'package:pokemon_market/providers/like_provider.dart';
import 'package:pokemon_market/pages/shopping_cart.dart'; // CartManager import 추가
import 'package:provider/provider.dart';

// 앱 진입점
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeManager()),
        ChangeNotifierProvider(create: (_) => LikeProvider()),
        ChangeNotifierProvider(create: (_) => CartManager()), // CartManager 추가
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
    final isDarkMode = Provider.of<ThemeManager>(context).isDarkMode;

    // iOS 스타일 페이지 전환 설정을 추가한 테마
    final modifiedLightTheme = lightTheme.copyWith(
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        },
      ),
    );

    final modifiedDarkTheme = darkTheme.copyWith(
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        },
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokemon Market',
      theme: isDarkMode ? modifiedDarkTheme : modifiedLightTheme,
      home: const HomePage(),
    );
  }
}
