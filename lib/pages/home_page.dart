import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon_market/widgets/common_appbar.dart';
import 'package:pokemon_market/widgets/common_text.dart';
import 'package:pokemon_market/widgets/home_page/home_page_list.dart';
import 'package:pokemon_market/theme/custom_theme.dart';
import 'package:pokemon_market/theme/theme_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ThemeManager _themeManager = ThemeManager();

  @override
  void initState() {
    super.initState();
    _themeManager.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    _themeManager.removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged(bool isDark) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = _themeManager.isDarkMode;

    return Theme(
      data: isDarkMode ? darkTheme : lightTheme,
      child: Scaffold(
        appBar: CommonAppbar(
          isDarkMode: isDarkMode,
          toggleTheme: _themeManager.toggleTheme,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              //TODO: 삼항연산자 사용해서 상품여부 확인필요
              CommonText(
                text: '상품이 없습니다.',
                fontSize: 24,
              ),
              HomePageList(),
            ],
          ),
        ),
        floatingActionButton: Fab(isDarkMode: isDarkMode),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

class Fab extends StatelessWidget {
  final bool isDarkMode;

  const Fab({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      backgroundColor:
          isDarkMode ? darkTheme.primaryColor : lightTheme.primaryColor,
      child: Icon(
        Icons.add,
        size: 30,
        weight: 800,
      ),
    );
  }
}
