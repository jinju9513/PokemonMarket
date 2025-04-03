import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon_market/widgets/common_text.dart';
import 'package:pokemon_market/widgets/home_page/home_page_list.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
      // 테마 변경 로직 - 실제 앱 테마 변경
      final brightness = isDarkMode ? Brightness.dark : Brightness.light;
      final systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarBrightness: brightness,
        systemNavigationBarIconBrightness: brightness,
        statusBarIconBrightness:
            brightness == Brightness.light ? Brightness.dark : Brightness.light,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: CommonText(
            text: 'POKE',
            fontSize: 24,
          ),
          actions: [
            IconButton(
              icon: Icon(
                isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                color: isDarkMode ? Colors.yellow : Colors.blueGrey,
              ),
              onPressed: toggleTheme,
            ),
          ],
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
        floatingActionButton: Fab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  FloatingActionButton Fab() {
    return FloatingActionButton(
      onPressed: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Icon(
        Icons.add,
        size: 30,
        weight: 800,
      ),
    );
  }
}
